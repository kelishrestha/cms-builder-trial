# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CmsBuilder
  # Application module
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Dir[Rails.root.join('lib', '**', '*.rb').to_s].each { |file| require(file) }

    # Disable fixtures creation while migration and
    # set default template engine to haml
    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :rspec, fixture: false
    end
  end
end
