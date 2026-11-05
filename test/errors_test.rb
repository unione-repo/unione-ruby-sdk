# frozen_string_literal: true

require 'test_helper'

# Errors of the client: kind, retryable?, code, HTTP status, method, hint, message.
class ErrorsTest < Minitest::Test
  include TestSupport

  def send_with(transport, request = send_request)
    client(transport).email.send_email(request)
  end

  def error_body(message, code)
    JSON.generate({ 'status' => 'error', 'message' => message, 'code' => code })
  end

  def test_api_error
    error = api_error { send_with(FakeTransport.new(400, error_body('Unknown recipient', 204))) }

    assert_equal ApiError::KIND_API, error.kind
    refute error.retryable?
    assert_equal 204, error.error_code
    assert_equal 400, error.http_status
    assert_equal 'email/send', error.api_method
    refute_nil error.hint
    refute_empty error.hint
    assert_equal 'Unknown recipient', error.api_message
    assert error.message.start_with?('email/send: '), error.message
    assert_includes error.message, '(API error 204, HTTP 400)'
    assert_includes error.message, 'Fix: '
    assert_equal({ 'status' => 'error', 'message' => 'Unknown recipient', 'code' => 204 }, error.response_body)
  end

  def test_rate_limit_and_server_errors_are_retryable
    [429, 503].each do |status|
      error = api_error { send_with(FakeTransport.new(status, error_body('Try again later', 1000))) }

      assert_equal ApiError::KIND_API, error.kind, "HTTP #{status}"
      assert error.retryable?, "HTTP #{status}"
      assert_equal status, error.http_status
    end
  end

  def test_response_that_is_not_json
    error = api_error { send_with(FakeTransport.new(502, '<html><body>502 Bad Gateway</body></html>')) }
    assert_equal ApiError::KIND_INVALID_RESPONSE, error.kind
    assert error.retryable?
    assert_equal 502, error.http_status
    assert_includes error.message, 'Bad Gateway'

    error = api_error { send_with(FakeTransport.new(200, 'OK')) }
    assert_equal ApiError::KIND_INVALID_RESPONSE, error.kind
    refute error.retryable?
    assert error.message.start_with?('email/send: '), error.message
  end

  def test_network_failure
    transport = FakeTransport.new { raise Errno::ECONNREFUSED, 'connect(2)' }
    error = api_error { send_with(transport) }

    assert_equal ApiError::KIND_NETWORK, error.kind
    assert error.retryable?
    assert_equal 0, error.http_status
    assert error.message.start_with?('email/send: HTTP request failed'), error.message
  end

  def test_timeout_of_the_transport
    error = api_error { send_with(FakeTransport.new { raise Net::ReadTimeout }) }

    assert_equal ApiError::KIND_TIMEOUT, error.kind
    assert error.retryable?
  end

  def test_timeout_of_the_default_transport
    with_server(->(_socket) { sleep 5 }) do |url|
      api = ::UniOne::UniOneClient.new(API_KEY, url, timeout: 0.3)
      error = api_error { api.email.send_email(send_request) }

      assert_equal ApiError::KIND_TIMEOUT, error.kind
      assert error.retryable?
    end
  end

  def test_empty_api_key_sends_nothing
    transport = FakeTransport.new
    error = api_error { client(transport, '').email.send_email(send_request) }

    assert_equal ApiError::KIND_INVALID_REQUEST, error.kind
    refute error.retryable?
    assert_equal 0, error.http_status
    assert error.message.start_with?('email/send: '), error.message
    assert_empty transport.requests
  end

  def test_missing_recipients_send_nothing
    cases = {
      'email/send: message.recipients is required' => [nil, []],
      'email/send: message.recipients[0].email is required' => [[{ 'email' => '' }], [{ 'substitutions' => {} }]]
    }
    cases.each do |message, values|
      values.each do |recipients|
        request = send_request
        if recipients.nil?
          request['message'].delete('recipients')
        else
          request['message']['recipients'] = recipients
        end
        transport = FakeTransport.new
        error = api_error { send_with(transport, request) }

        assert_equal ApiError::KIND_INVALID_REQUEST, error.kind
        assert_equal message, error.message
        assert_empty transport.requests
      end
    end
  end

  def test_long_api_message_is_cut_in_the_message_only
    text = 'x' * 600
    error = api_error { send_with(FakeTransport.new(400, error_body(text, 204))) }

    assert_includes error.message, "#{'x' * 500}... (600 chars)"
    refute_includes error.message, 'x' * 501
    assert_equal text, error.api_message
  end

  def test_error_code_as_a_string
    error = api_error { send_with(FakeTransport.new(400, error_body('Unknown recipient', '204'))) }
    assert_equal 204, error.error_code

    error = api_error { send_with(FakeTransport.new(400, error_body('Bad request', 'abc'))) }
    assert_nil error.error_code
    assert_nil error.hint
    assert_includes error.message, '(HTTP 400)'
  end

  def test_error_of_a_custom_transport_keeps_its_fields
    own = ApiError.new('quota exceeded', http_status: 429, error_code: 1000, hint: 'wait', api_message: 'quota')
    error = api_error { send_with(FakeTransport.new { raise own }) }

    assert_equal 'email/send', error.api_method
    assert_equal 'email/send: quota exceeded', error.message
    assert_equal ApiError::KIND_API, error.kind
    assert_equal 429, error.http_status
    assert_equal 1000, error.error_code
    assert_equal 'wait', error.hint
    assert_equal 'quota', error.api_message
    assert error.retryable?

    error = api_error { send_with(FakeTransport.new { raise ApiError, 'proxy down' }) }
    assert_equal ApiError::KIND_NETWORK, error.kind
    assert error.retryable?
  end
end
