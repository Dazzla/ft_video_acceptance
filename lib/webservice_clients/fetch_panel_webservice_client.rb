# frozen_string_literal: true
require 'rest-client'
require_relative 'video_webservice_client'
require_relative 'metadata_description_webservice_client'
require_relative '../../config/config'

###
# Extracts and parses definitions from metadata.
class FetchPanelWebserviceClient < VideoWebserviceClient

  include Config

  def initialize(user, url)
    super(user, url)
  end

  # Returns URL for individual definition requests
  #
  # @param name [String] :name of description to retrieve
  # @return [URI]
  def build_url_for_data_definition(name)
    id = MetadataDescriptionWebserviceClient.new(WSUser.new).retrieve_id_with_name(name)
    "#{Constants::MIO_WS_URL}/metadataDefinitions/#{id}/definition"
  end

  # Processes panel elements from description data, storing them in a Hash
  #
  # @return [Hash] to generate CSS Selectors on page
  def extract_panel_elements
    definitions = {}
    retrieve_panel_definitions.each do |element|
      definitions[element['name']] = element['type']
    end
    definitions
  end

  # Takes a metadata definition id and returns description data
  #
  # @param id [String] id of element
  # @return [Hash] element
  def fetch_panel_description_by_id(id)
    mio_client = VideoWebserviceClient.new(WSUser.new,
                                           "#{Constants::MIO_WS_URL}/metadataDefinitions/#{id}/definition")
    mio_client.retrieve_resource
  end

  # Wrapper method to retrieve text field elements from description metadata
  #
  # @return [Hash]
  def extract_text_field_elements
    extract_elements 'text'
  end

  # Wrapper method to retrieve selector elements from description metadata
  #
  # @return [Hash]
  def extract_selector_elements
    extract_elements 'single-option'
  end

  # Wrapper method to retrieve URL elements from description metadata
  #
  # @return [Hash]
  def extract_url_elements
    extract_elements 'url'
  end

  # Wrapper method booleans (to implement checkboxes or radios) from description metadata
  #
  # @return [Hash]
  def extract_boolean_elements
    extract_elements 'boolean'
  end

  # Wrapper method to retrieve img elements from description metadata
  #
  # @return [Hash]
  def extract_image_elements
    extract_elements 'image'
  end

  # Retrieves panel node from webservice response
  #
  # @return [Hash]
  def retrieve_panel_definitions
    retrieve_resource['definition']
  end

  private

  # Extracts elements of given type (text, single-option etc), stores in Hash
  #
  # @param type [String] requested element type to extract and store
  # @return [Hash] stored elements of requested type
  def extract_elements(type)
    elements = {}
    extract_panel_elements.each do |key, value|
      elements[key] = value if value == type
    end
    elements
  end

end
