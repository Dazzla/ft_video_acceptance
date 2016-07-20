# frozen_string_literal: true
require 'test/unit'
require_relative '../../../test/video_test'
require_relative '../../../lib/pages/in_development/publish_video_page'
require_relative '../../../lib/webservice_clients/publish_panel_webservice_client'

class PublishVideoPageTest < VideoTest

  def setup
    @browser = Watir::Browser.new :chrome
    @publish_video_page = PublishVideoPage.new @browser
    @retrieve_publish_panels_client = PublishPanelWebserviceClient.new

    VCR.use_cassette 'expected publish page elements' do
      fetch_expected_page_elements
    end
  end

  def fetch_expected_page_elements
    @publish_video_project_form_attributes = {}
    @retrieve_publish_panels_client.extract_panel_elements.each do |key, value|
      @publish_video_project_form_attributes[key] = value
    end
  end

  def test_has_attributes
    @publish_video_project_form_attributes.each_key do |attribute|
      attribute_name = attribute.tr('-', '_')
      info_logger :info, "attribute_name: #{attribute_name}"
      assert((@publish_video_page.respond_to? "#{attribute_name}_element") || (attribute_name == 'brightcove_metadata_tags'))
    end
  end

  def teardown
    @browser.close
  end

end
