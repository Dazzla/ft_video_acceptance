# frozen_string_literal: true
require 'test/unit'
require_relative '../test_helper'
require_relative '../../lib/webservice_clients/create_ingest_asset_webservice_client'
require_relative '../../test/data/ws_user'

class IngestPanelClientTest < VideoTest

  def setup
    VCR.use_cassette 'new ingest webservice client' do
      @mio_ingest_assets_panel_client = CreateIngestAssetWebserviceClient.new(WSUser.new)
    end

    @mio_metadata_service = MetadataDescriptionWebserviceClient.new(WSUser.new)
  end

  def test_build_url_for_data_definition
    panel_name = INGEST_METADATA_NAME
    VCR.use_cassette 'get id from name' do
      @id = @mio_metadata_service.retrieve_id_with_name(panel_name)
    end
    VCR.use_cassette 'data definition url' do
      @url = @mio_ingest_assets_panel_client.build_url_for_data_definition panel_name
    end
    assert_match(%r{metadataDefinitions/#{@id}/definition}, @url)
  end

  def test_extract_ingest_asset_panel_elements
    VCR.use_cassette 'get ingest panel elements' do
      @ingest_panel_elements = @mio_ingest_assets_panel_client.extract_panel_elements
    end
    assert_kind_of(Hash, @ingest_panel_elements)
    assert(@ingest_panel_elements.has_key?('clip-type') || @ingest_panel_elements.has_value?('text') ||
               @ingest_panel_elements.has_key?('project') || @ingest_panel_elements.has_value?('single-option') )

  end

  def test_retrieve_ingest_panel_definitions
    VCR.use_cassette 'get ingest panel definitions' do
      @ingest_panel_definitions = @mio_ingest_assets_panel_client.retrieve_panel_definitions
    end
    assert_kind_of(Array, @ingest_panel_definitions)
  end

end
