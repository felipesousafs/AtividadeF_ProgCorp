require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AtividadeFProgcorp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.i18n.default_locale = "pt-BR"
    config.i18n.available_locales = %w[pt-BR en]
    config.time_zone = 'America/Fortaleza'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
