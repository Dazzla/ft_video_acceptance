# frozen_string_literal: true
require_relative '../panel_page'
require_relative '../../webservice_clients/publish_panel_webservice_client'
require_relative '../../../test/factories/publish_video_factory'

##
# PageObject for Publish Video page
class PublishVideoPage < PanelPage

  include Logging

  VCR.use_cassette 'publish page elements' do
    define_page_elements(PublishPanelWebserviceClient.new)
  end

  span :export_button, text: 'submit'

  ##
  # Uses the web interface to publish the project
  #
  # @param asset [PublishVideo]
  # @return [String]
  def publish_video(asset=FactoryGirl.build(:publish_video))
    headline_element.when_present.value = asset.headline
    long_lead_element.value = asset.long_lead
    short_lead_element.value = asset.short_lead
    link_1_element.value = asset.related_content
    credit_element.value = asset.credit
    freelance_video_editor_element.value = asset.freelance_video_editor
    error_logger :warn, 'Cannot access Video Publish Page restrictions at present: outstanding bug'
    error_logger :warn, 'Video Publish Page: Poster Image not implemented'
    error_logger :warn, 'Video Publish Page: Thumbnail not implemented'
    error_logger :warn, 'Assert not yet possible on Video Publish page'
    export_button
  end

end
