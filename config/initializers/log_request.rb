# frozen_string_literal: true

# https://api.rubyonrails.org/classes/ActiveSupport/Notifications.html
ActiveSupport::Notifications.subscribe('process_action.action_controller') do |name, start, finish, id, payload|
  if payload[:params]['token'].present?
    RequestLoggerService.new(payload, start_time: start, finish_time: finish).execute!
  end
end
