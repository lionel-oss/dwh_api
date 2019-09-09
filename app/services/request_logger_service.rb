# frozen_string_literal: true

class RequestLoggerService
  attr_reader :payload, :start_time, :finish_time

  def initialize(payload, start_time: 0, finish_time: 0)
    @payload = payload
    @start_time = start_time
    @finish_time = finish_time
  end

  def execute!
    ::RequestLog.create(
      endpoint: payload[:path],
      token: payload[:params]['token'],
      params: payload[:params].reject { |k, _| k[/token|controller|action/] },
      db_duration: payload[:db_runtime],
      total_duration: (finish_time - start_time) * 1000,
      status: status_message,
      error_message: error_message,
      ip_address: ip_address_from_payload,
      http_protocol: payload[:headers]['HTTPS'] == 'on' ? 'https' : 'http',
      server_name: ENV['SERVER_NAME']
    )
  end

  private

  def error_message
    return payload[:exception].join(' ') if payload[:exception].present?

    payload[:headers]['action_controller.instance'].headers['exception']
  end

  def status_message
    return 'success' if error_message.blank?

    payload[:retries] ? 'failed (retry)' : 'failed'
  end

  def ip_address_from_payload
    # string in format <original_ip>, <balancer_ip>
    redirected_ip = payload[:headers]['HTTP_X_FORWARDED_FOR']&.split(',')&.first
    redirected_ip ? redirected_ip : payload[:headers]['action_dispatch.remote_ip'].to_s
  end

  def token_from_params(params)
    Token.find_by(code: params['token'])
  end
end
