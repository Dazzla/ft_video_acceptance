# frozen_string_literal: true
require 'page-object'
require_relative '../../config/config'

##
# Base class for all Panel PageObjects
class PanelPage

  BLUE = /51, 153, 204/
  GREY = /158, 158, 158/

  NO_OF_LOGIN_TEXTBOXES = 2

  include Config
  include PageObject

  element :site_header, id: 'TBC'
  element :test_element, id: 'textarea-test_element'
  div(:submit_success_indicator, id: 'success-handler')

  ##
  # Extracts element type from Panel format IDs
  #
  # @param element_id_value [String] ID tag of element <element id=<ID>
  # @return String
  def self.element_type(element_id_value)
    element_id_value.split('-')[0]
  end

  ##
  # Extracts element ID name from Panel format IDs
  #
  # @param element_id_value [String] ID tag of element <element id=<ID>
  # @return String
  def self.element_id(element_id_value)
    element_id_value.split('-')[1]
  end

  # Retrieves element descriptions from web service and defines them as
  # PageObject::Elements
  #
  # @param webservice_client [MioFetchPanelWebserviceClient]
  # @return [Object]
  def self.define_page_elements(webservice_client)
    define_text_elements(webservice_client)
    define_selector_elements(webservice_client)
    define_link_elements(webservice_client)
    define_boolean_elements(webservice_client)
    define_image_elements(webservice_client)
    define_url_elements(webservice_client)
  end

  # @return PageObject::Element::Image
  def self.define_image_elements(webservice_client)
    webservice_client.extract_image_elements.each_key do |name|
      element_name = name.tr('-', '_')
      img(element_name, id: Regexp.new(name))
    end
  end

  # @return PageObject::Element::URL
  def self.define_url_elements(webservice_client)
    webservice_client.extract_url_elements.each_key do |name|
      element_name = name.tr('-', '_')
      text_field(element_name, id: Regexp.new(name))
    end
  end

  # @return PageObject::Element::Element
  def self.define_boolean_elements(webservice_client)
    webservice_client.extract_boolean_elements.each_key do |name|
      element_name = name.tr('-', '_')
      element(element_name, id: 'TBC') # TBC - depends on implementation
    end
  end

  # @return PageObject::Element::Link
  def self.define_link_elements(webservice_client)
    webservice_client.extract_url_elements.each_key do |name|
      link(name, id: Regexp.new(name))
    end
  end

  # @return PageObject::Element::Div
  def self.define_selector_elements(webservice_client)
    webservice_client.extract_selector_elements.each_key do |name|
      element_name = name.tr('-', '_')
      div(element_name + 'div', id: Regexp.new(name))
      sl = div(element_name) { method("#{element_name}div_element").call.div(id: /undefined/) }
      sl
    end
  end

  # @return PageObject::Element::TextArea
  def self.define_text_elements(webservice_client)
    webservice_client.extract_text_field_elements.each_key do |name|
      element_name = name.tr('-', '_')
      textarea(element_name, id: Regexp.new(name))
    end
  end

  ##
  # User is logged in?
  #
  # @return [Boolean]
  def logged_in?
    self.wait_until(60){@browser.svgs[1].attribute_value('style') =~ BLUE}
    !!(@browser.svgs[1].attribute_value('style') =~ BLUE)
  end

  def submit_successful?
    wait_until(5, false){submit_success_indicator?}
    submit_success_indicator?
  end

end
