require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require "slim"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LoveChild
  class Application < Rails::Application
    # Bower.
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << Rails.root.join('app', 'assets', 'javascripts', 'lib')

    # Bootstrap.
    Sass::Script::Number.precision = 8

    Slim::Engine.set_default_options tabsize: 2

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.prefix = "assets"

    config.browserify_rails.paths = [lambda { |p| p.start_with?(Rails.root.join("app").to_s) }]

    config.browserify_rails.commandline_options = "--debug --fast -t coffeeify --extension=\".js.coffee\""
  end
end
