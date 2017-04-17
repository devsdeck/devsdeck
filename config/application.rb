require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Notes
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    config.action_view.field_error_proc = Proc.new { |html_tag, _instance|
      html_tag.html_safe
    }
  end
end
