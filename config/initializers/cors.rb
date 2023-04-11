# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if %w[development test].include?(Rails.env)
      origins '*'
      resource '*',
               headers: :any,
               methods: %i[get]
    else
      origins %r{https://.*.#{ENV.fetch('DOMAIN_NAME')}}
      resource '/api/v1/*',
               headers: :any,
               methods: %i[get]
    end
  end
end
