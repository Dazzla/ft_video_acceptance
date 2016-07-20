# frozen_string_literal: true
require 'test/unit'
require_relative 'ws_user'

class WSUserTest < Test::Unit::TestCase

  def setup
    @test_user = WSUser.new
  end

  def test_user_has_default_username
    assert_not_empty(@test_user.username)
  end

  def test_user_has_default_password
    assert_not_empty(@test_user.password)
  end

  def test_username_and_password_can_be_set
    @custom_test_user = WSUser.new('Doris', 'DorisSecret')
    assert_equal(@custom_test_user.username, 'Doris')
    assert_equal(@custom_test_user.password, 'DorisSecret')
  end

end
