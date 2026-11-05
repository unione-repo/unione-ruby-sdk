# frozen_string_literal: true

require 'test_helper'

# Requests and responses of the client: path, headers, query, JSON body, decoded models.
class ClientTest < Minitest::Test
  include TestSupport

  SEND_RESPONSE = '{"status":"success","job_id":"1ZymBc-00041N-9X","emails":["alex@example.com"],' \
                  '"failed_emails":{"bad@example.com":"unsubscribed"}}'

  def test_send_posts_the_message_and_parses_the_response
    transport = FakeTransport.new(200, SEND_RESPONSE)
    recipient = ::UniOne::Api::Email::Model::MessageObjectRecipientsItem.from_address('Alex <alex@example.com>')
    request = ::UniOne::Api::Email::Model::EmailSendRequest.new(
      message: ::UniOne::Api::Email::Model::MessageObject.new(
        recipients: [recipient],
        body: ::UniOne::Common::Model::BodyObject.html('<p>Hi</p>'),
        subject: 'Hello',
        from_email: 'shop@example.com'
      )
    )

    response = client(transport).email.send_email(request)

    assert_equal 1, transport.requests.size
    sent = transport.requests[0]
    assert_equal 'POST', sent[:method]
    assert_equal '/api/v1/email/send.json', sent[:uri].path
    assert_equal [['platform', 'ruby-sdk.1.3.0']], URI.decode_www_form(sent[:uri].query)
    assert_equal 'ruby-sdk.1.3.0', ::UniOne::Client::PLATFORM
    assert_equal API_KEY, sent[:headers]['X-API-KEY']
    assert_equal 'application/json', sent[:headers]['Content-Type']
    expected = {
      'message' => {
        'recipients' => [{ 'email' => 'alex@example.com', 'substitutions' => { 'to_name' => 'Alex' } }],
        'body' => { 'html' => '<p>Hi</p>' },
        'subject' => 'Hello',
        'from_email' => 'shop@example.com'
      }
    }
    assert_equal expected, JSON.parse(sent[:body])
    assert_equal '1ZymBc-00041N-9X', response.job_id
    assert_equal ['alex@example.com'], response.emails
    assert_equal({ 'bad@example.com' => 'unsubscribed' }, response.failed_emails)
  end

  def test_send_accepts_a_hash_in_the_api_format
    transport = FakeTransport.new(200, SEND_RESPONSE)

    client(transport).email.send_email(send_request)

    assert_equal send_request, JSON.parse(transport.requests[0][:body])
  end

  def test_info_posts_an_empty_body_and_parses_the_response
    transport = FakeTransport.new(200, '{"status":"success","user_id":11344,"email":"user@example.com"}')

    info = client(transport).system.info

    sent = transport.requests[0]
    assert_equal '/api/v1/system/info.json', sent[:uri].path
    assert_equal({}, JSON.parse(sent[:body]))
    assert_equal 11344, info.user_id
    assert_equal 'user@example.com', info.email
  end

  def test_platform_and_headers_options
    transport = FakeTransport.new
    api = client(transport, platform: 'rails.1.0.0', headers: { 'X-Request-Id' => '42', 'User-Agent' => 'my-app' })

    api.api_client.call('/system/ping.json')

    sent = transport.requests[0]
    assert_equal [['platform', 'rails.1.0.0,ruby-sdk.1.3.0']], URI.decode_www_form(sent[:uri].query)
    assert_equal '42', sent[:headers]['X-Request-Id']
    assert_equal 'my-app', sent[:headers]['User-Agent']
    assert_equal API_KEY, sent[:headers]['X-API-KEY']
  end

  def test_host_gives_the_base_url
    config = ::UniOne.client(API_KEY, 'eu1.example.com').api_client.config
    assert_equal "https://eu1.example.com#{::UniOne::Client::Configuration::BASE_PATH}", config.base_url

    config = ::UniOne.client(API_KEY, 'http://127.0.0.1:9/api/v1/').api_client.config
    assert_equal 'http://127.0.0.1:9/api/v1', config.base_url
  end

  def test_default_transport_against_a_local_server
    body = '{"status":"success","job_id":"local-job"}'
    with_server(->(socket) { socket.write(http_response('200 OK', body)) }) do |url, seen|
      response = ::UniOne::UniOneClient.new(API_KEY, url).email.send_email(send_request)

      assert_equal 'local-job', response.job_id
      assert_match(%r{\APOST /api/v1/email/send\.json\?platform=ruby-sdk\.1\.3\.0 HTTP/1\.1\r\n}, seen[:head])
      assert_match(/^X-API-KEY: test-key\r$/i, seen[:head])
      assert_match(%r{^Content-Type: application/json\r$}i, seen[:head])
      assert_equal send_request, JSON.parse(seen[:body])
    end
  end
end
