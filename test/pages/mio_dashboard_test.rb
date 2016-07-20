# frozen_string_literal: true
require_relative '../../lib/pages/mio_dashboard_page'
require 'test-unit'
require_relative '../video_test'

class MioDashboardTest < VideoTest

  def setup
    @browser = Watir::Browser.new :phantomjs
    @dashboard = MioDashboardPage.new @browser
    @tabs = %i(desktop_tab assets_tab players_tab tasks_tab jobs_tab workflows_tab resources_tab)
  end

  def test_displayed
    assert_respond_to(@dashboard, :displayed?)
  end

  def test_change_section
    assert_respond_to(@dashboard, :change_section)
  end

  def test_has_tabs
    @tabs.each do |tab|
      assert_respond_to(@dashboard, tab)
    end
  end

  def teardown
    @browser.close
  end

end
