# frozen_string_literal: true
require 'test/unit'
require_relative '../../test/data/ws_user'
require_relative '../test_helper'
require_relative '../../lib/webservice_clients/create_project_panel_webservice_client'

class CreateProjectPanelClientTest < VideoTest

  def setup
    @mio_metadata_service = MetadataDescriptionWebserviceClient.new(WSUser.new)
    VCR.use_cassette 'new project webservice client' do
      @mio_fetch_panels_client = CreateProjectPanelWebserviceClient.new(WSUser.new)
    end
  end

  def test_build_url_for_data_definition
    panel_name = PROJECT_METADATA_NAME
    VCR.use_cassette 'get id from name' do
      @id = @mio_metadata_service.retrieve_id_with_name(panel_name)
    end

    VCR.use_cassette 'panel name' do
      @url = @mio_fetch_panels_client.build_url_for_data_definition panel_name
    end
    assert_match(%r{metadataDefinitions/#{@id}/definition}, @url)
  end

  def test_extract_create_project_panel_elements
    VCR.use_cassette 'panel elements' do
      @create_project_panel_elements = @mio_fetch_panels_client.extract_panel_elements
    end
    assert_kind_of(Hash, @create_project_panel_elements)
    assert(@create_project_panel_elements.has_key?('project') || @create_project_panel_elements.has_key?('text'),
           'Does not have expected element (project => text)')
  end

  def test_retrieve_create_project_panel_definitions
    VCR.use_cassette 'panel definitions' do
      @panel_definitions = @mio_fetch_panels_client.retrieve_panel_definitions
    end
    assert_kind_of(Array, @panel_definitions)
  end

end
