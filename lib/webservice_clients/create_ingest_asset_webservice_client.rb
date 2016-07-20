# frozen_string_literal: true
require_relative 'fetch_panel_webservice_client'

##
# Retrieves metadata definition to create accessors for the Ingest Asset web page
class CreateIngestAssetWebserviceClient < FetchPanelWebserviceClient

  def initialize(user=WSUser.new)
    super(user, build_url_for_data_definition(INGEST_METADATA_NAME))
  end

end
