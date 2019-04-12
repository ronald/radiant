module Radiant
  class AdminController < ::Radiant::ApplicationController
    protect_from_forgery

    # from login system
    prepend_before_action :authorize, :authenticate

    before_action :set_current_user
    before_action :set_user_locale
    before_action :set_standard_body_style, only: [:new, :edit, :update, :create]

  private

    def set_current_user
      UserActionObserver.instance.current_user = current_user
    end

    def set_user_locale
      I18n.locale = current_user && !current_user.locale.blank? ? current_user.locale : Radiant::Config['default_locale']
    end

    def set_standard_body_style
      @body_classes ||= []
      @body_classes.concat(%w(reversed))
    end
  end
end