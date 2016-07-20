# frozen_string_literal: true
require_relative 'panel_page'

##
# Page Object for acceptance testing of Mio Dashboard
#
# @deprecated - legacy page
class MioDashboardPage < PanelPage

  link :desktop_tab, id: 'desktop_section_tab'
  link :assets_tab, id: 'assets_section_tab'
  link :players_tab, id: 'players_section_tab'
  link :tasks_tab, id: 'tasks_section_tab'
  link :jobs_tab, id: 'jobs_section_tab'
  link :workflows_tab, id: 'workflows_section_tab'
  link :resources_tab, id: 'resources_section_tab'

  div :dashboard_container, id: 'container'
  div :current_feature_container, id: 'left_col'

  # Check whether the page is displayed
  #
  # @return [Boolean] page displayed?
  def displayed?
    wait_until { dashboard_container? }
  end

  # Change between dashboard page sections and check for success
  #
  # @return [Boolean]
  def change_section(section)
    previous_feature = current_feature_container_element.when_present.text
    select_tab section
    current_feature = current_feature_container_element.text
    true unless current_feature == previous_feature
  end

  # Select dashboard tab
  #
  # @param section [String] name of tab to select
  # @return nil
  def select_tab(section)
    send("#{section}_tab_element").when_present.click
  end

end
