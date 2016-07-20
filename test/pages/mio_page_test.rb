# frozen_string_literal: true
require 'test/unit'
require_relative '../../lib/pages/panel_page'
require_relative '../test_helper'

class MioPageTest < VideoTest

  def setup
    @browser = Watir::Browser.new :phantomjs
    @base_page = PanelPage.new @browser
  end

  def test_has_common_header
    assert @base_page.respond_to? :site_header, "'site_header' missing from page"
  end

  def test_can_retrieve_element_type
    assert PanelPage.respond_to? :element_type
    assert_equal('type_name', PanelPage.element_type('type_name-id_name'))
  end

  def test_can_retrieve_element_id
    assert PanelPage.respond_to? :element_id
    assert_equal('id_name', PanelPage.element_id('type_name-id_name'))
  end

  def teardown
    @browser.close
  end

end
