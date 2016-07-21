# frozen_string_literal: true
require_relative 'fetch_panel_webservice_client'

##
# Retrieves metadata definition to create accessors for the Create Project web page
class CreateProjectPanelWebserviceClient < FetchPanelWebserviceClient

  def initialize(user=WSUser.new, metadata_name=nil)
    super(user, PROJECT_METADATA_NAME)
  end

end
