# frozen_string_literal: true
##
# PageObject for ingteracting with Login form
#
class FTLoginPage < PanelPage

  include Logging
  include Constants

  page_url "#{Constants::MIO_ROOT_URL}/<%=params[:panel]%>"

  link(:log_in_button, href: /login/)
  link(:log_out_button, href: /logout/)
  text_field(:username, id: /Username/)
  text_field(:password, id: /Password/)
  text_field(:two_factor_code_field, id: /Two-factorCode/)
  div(:login_container, id: 'handler__login')
  button(:submit_button, text: 'Login')

  ##
  # Logs a user in through the web interface
  #
  # @param [Hash] user admin user
  # @return [TrueClass]
  def log_in(user=Constants::ADMIN_USER)
    log_in_button_element.when_present.click
    self.username = user[:username]
    self.password = user[:password]
    self.two_factor_code_field = OTP.now
    submit_button
    error_logger :warn, 'Login Failed' unless logged_in?
  end

end
