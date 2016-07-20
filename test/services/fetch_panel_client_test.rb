# frozen_string_literal: true
require 'test/unit'
require_relative '../../test/data/ws_user'
require_relative '../../lib/webservice_clients/fetch_panel_webservice_client'
require_relative '../test_helper'

class FetchPanelClientTest < VideoTest

  TEST_FETCH_URL = "#{Config::Constants::MIO_WS_URL}/metadataDefinitions/#{PANEL_ID}/definition"

  def setup
    @mio_fetch_panels_client = FetchPanelWebserviceClient.new(WSUser.new, TEST_FETCH_URL)
  end

  def test_get_panel_elements
    VCR.use_cassette 'get panel elements' do
      @elements = @mio_fetch_panels_client.extract_panel_elements
    end
    raise "Element #{@elements.class} is not a Hash" unless
        @elements.class.equal? Hash
  end

  def test_get_text_fields
    VCR.use_cassette 'get text elements' do
      @text_fields = @mio_fetch_panels_client.extract_text_field_elements
    end
    @text_fields.each do |key, value|
      raise "#{key} is not a text field (#{value}" unless value == 'text'
    end
  end

  def test_get_selectors
    VCR.use_cassette 'get selectors' do
      @selectors = @mio_fetch_panels_client.extract_selector_elements
    end
    @selectors.each do |key, value|
      raise "#{key} is not a selector (#{value}" unless value == 'single-option'
    end
  end

  def test_retrieve_panel_definitions
    VCR.use_cassette 'get panel definitions' do
      @definitions = @mio_fetch_panels_client.retrieve_panel_definitions
    end
    raise "Element #{@definitions.class} is not an Array" unless
        @definitions.class.equal? Array
  end

  def test_fetch_panel_description_by_id
    VCR.use_cassette 'get panel definition by id' do
      @panel_description = @mio_fetch_panels_client.fetch_panel_description_by_id(PANEL_ID)
    end
    assert((@panel_description.has_key? 'name'))
  end

end
