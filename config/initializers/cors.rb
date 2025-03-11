# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Change '*' to specific frontend URL for security (e.g., 'http://localhost:3000')
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options],
             credentials: false
  end
end
