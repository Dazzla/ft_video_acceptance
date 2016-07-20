# frozen_string_literal: true
require 'test/unit'
require_relative '../test_helper'
require_relative '../../lib/webservice_clients/publish_panel_webservice_client'

class PublishPanelClientTest < VideoTest

  def setup
    VCR.use_cassette 'new publish webservice client' do
      @mio_publish_panel_client = PublishPanelWebserviceClient.new(WSUser.new)
    end
    @mio_metadata_service = MetadataDescriptionWebserviceClient.new(WSUser.new)
  end

  def test_build_url_for_data_definition
    panel_name = PUBLISH_METADATA_NAME
    VCR.use_cassette 'publish get id from name' do
      @id = @mio_metadata_service.retrieve_id_with_name(panel_name)
    end
    VCR.use_cassette 'url for data definition' do
      @url = @mio_publish_panel_client.build_url_for_data_definition panel_name
    end
    assert_match(%r{metadataDefinitions/#{@id}/definition}, @url)
  end

  def test_extract_publish_panel_elements
    VCR.use_cassette 'extract publish panel elements' do
      @elements = @mio_publish_panel_client.extract_panel_elements
    end
    assert_kind_of(Hash, @elements)
    assert(@elements.has_key?('brand') || @elements.has_key?('text'),
           'Does not have expected element (headline => text)')
  end

  def test_retrieve_publish_panel_definitions
    VCR.use_cassette 'extract publish panel definitions' do
      @ingest_panel_definitions = @mio_publish_panel_client.retrieve_panel_definitions
    end
    assert_kind_of(Array, @ingest_panel_definitions)
  end

end
