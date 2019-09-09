# frozen_string_literal: true

class RequestLog < ApplicationRecord
  rails_admin do
    list do
      field :endpoint
      field :server_name
      field :status
      field :db_duration do
        label 'Duration db/total'
        pretty_value do
          db_duration = (bindings[:object].db_duration.to_f / 1000).round(2)
          total_duration = (bindings[:object].total_duration.to_f / 1000).round(2)
          "#{db_duration} / #{total_duration}"
        end
      end
      field :timestamp do
        pretty_value do
          bindings[:object].created_at.in_time_zone('CET').strftime('%Y-%m-%d at %I:%M %p %Z')
        end
      end
    end

    show do
      field :endpoint
      field :token
      field :status
      field :error_message
      field :params
      field :ip_address
      field :http_protocol

      field :db_duration do
        formatted_value do
          (value.to_f / 1000).round(2)
        end
      end

      field :created_at do
        label { 'Timestamp' }

        formatted_value do
          (value.in_time_zone('CET').strftime('%Y-%m-%d at %I:%M %p %Z'))
        end
      end

      field :total_duration do
        formatted_value do
          (value.to_f / 1000).round(2)
        end
      end
    end
  end
end
