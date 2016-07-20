# frozen_string_literal: true
require_relative 'panel_page'
require_relative '../../config/config'

# Legacy Mio Login Page, included for reference
#
# @deprecated legacy page
class MioLoginPage < PanelPage

  page_url Constants::MIO_ROOT_URL

  text_field  :username_field, id: 'j_username'
  text_field  :password_field, id: 'j_password'
  span        :submit_span, id: 'submit_control'
  button      :submit_button, id: 'submit_control-button'

  # Complete login form
  #
  # @param user [Hash] user credentials
  #       :username [String]
  #       :password [String]
  def log_in(user=Constants::ADMIN_USER)
    true if @browser.link(title: 'Logout').present?
    self.username_field = user[:username]
    self.password_field = user[:password]
    submit_button
  end

end
