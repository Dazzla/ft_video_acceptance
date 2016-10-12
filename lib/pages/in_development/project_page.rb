# frozen_string_literal: true
require_relative '../panel_page'
require_relative '../../../lib/webservice_clients/create_project_panel_webservice_client'

##
# PageObject for Create Video page
class ProjectPage < PanelPage

  include Logging

  VCR.use_cassette 'project page elements' do
    define_page_elements(CreateProjectPanelWebserviceClient.new)
  end

  div(:form, id: 'handler__formBuilder')
  button(:submit_project)

  ##
  # Creates a bare-bones project in the web interface
  #
  # @param [String] project_name
  # @return [TrueClass]
  def create_project(project_name)
    sleep 0.5
    project_element.when_present.value = project_name
    submit_project_element.when_present.click
  end

  ##
  # Checks whether the panel is displayed
  #
  # @return [Boolean]
  def page_displayed?
    project?
  end

end
