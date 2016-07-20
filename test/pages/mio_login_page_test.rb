# frozen_string_literal: true
require_relative '../../lib/pages/mio_login_page'
require_relative '../../lib/pages/panel_page'
require 'test-unit'
require_relative '../test_helper'

class MioLoginPageTest < VideoTest

  def setup
    @browser = Watir::Browser.new :phantomjs
    @login_page = MioLoginPage.new @browser
  end

  def test_can_log_in
    assert_respond_to(@login_page, :log_in)
  end

  def test_has_username_field
    assert_respond_to(@login_page, :username_field)
  end

  def test_has_password_field
    assert_respond_to(@login_page, :password_field)
  end

  def test_has_submit_button
    assert_respond_to(@login_page, :submit_button)
  end

  def teardown
    @browser.close
  end

end
