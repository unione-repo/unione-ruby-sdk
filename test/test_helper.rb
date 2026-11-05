# frozen_string_literal: true

# Tests of the SDK: no network and no real API. Every request goes to FakeTransport or to a one-shot HTTP server
# on 127.0.0.1 started by the test.
#
#   ruby -Ilib -Itest -e 'Dir["test/**/*_test.rb"].sort.each { |f| require File.expand_path(f) }'
require 'minitest/autorun'
require 'json'
require 'socket'
require 'uri'
require 'unione'

# HTTP layer of the tests: records every request and answers [status, body] (or what the block returns / raises).
class FakeTransport
  attr_reader :requests

  def initialize(status = 200, body = '{"status":"success"}', &block)
    @status = status
    @body = body
    @block = block
    @requests = []
  end

  def call(method, uri, headers, body, timeout)
    @requests << { method: method, uri: uri, headers: headers, body: body, timeout: timeout }
    return @block.call(method, uri, headers, body, timeout) if @block

    [@status, @body]
  end
end

module TestSupport
  API_KEY = 'test-key'
  # Base URL of the clients of the tests: always set explicitly, never the default host of the API
  BASE_URL = 'http://127.0.0.1:9/api/v1'
  ApiError = ::UniOne::Client::ApiError

  # A client on the fake transport
  def client(transport, api_key = API_KEY, **options)
    ::UniOne::UniOneClient.new(api_key, BASE_URL, transport: transport, **options)
  end

  # A valid email/send request in the API format
  def send_request
    {
      'message' => {
        'recipients' => [{ 'email' => 'alex@example.com' }],
        'body' => { 'html' => '<p>Hi</p>' },
        'subject' => 'Hello',
        'from_email' => 'shop@example.com'
      }
    }
  end

  # The error raised by the block (fails when nothing is raised)
  def api_error(&block)
    assert_raises(ApiError, &block)
  end

  # A one-shot HTTP server on 127.0.0.1: reads one request, then reply.call(socket) writes the response (or sleeps).
  # Yields the base URL of the server and a Hash that gets :head (request line and headers) and :body of the request.
  def with_server(reply)
    server = TCPServer.new('127.0.0.1', 0)
    seen = {}
    thread = Thread.new do
      begin
        socket = server.accept
        head = +''
        while (line = socket.gets)
          head << line
          break if line == "\r\n"
        end
        length = head[/^content-length:\s*(\d+)/i, 1].to_i
        seen[:head] = head
        seen[:body] = length.positive? ? socket.read(length) : ''
        reply.call(socket)
      rescue StandardError
        nil
      ensure
        socket&.close
      end
    end
    yield "http://127.0.0.1:#{server.addr[1]}/api/v1", seen
  ensure
    thread&.kill
    thread&.join(1)
    server&.close
  end

  # A raw HTTP/1.1 response
  def http_response(status, body, type = 'application/json')
    "HTTP/1.1 #{status}\r\nContent-Type: #{type}\r\n" \
      "Content-Length: #{body.bytesize}\r\nConnection: close\r\n\r\n#{body}"
  end
end
