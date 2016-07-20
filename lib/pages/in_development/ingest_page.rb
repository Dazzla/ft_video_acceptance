# frozen_string_literal: true
require 'page-object'
require_relative '../panel_page'
require_relative '../../../lib/webservice_clients/create_ingest_asset_webservice_client'
require_relative '../../../test/factories/video_asset_factory'

##
# PageObject for Ingest Assets page
class IngestPage < PanelPage

  include Logging

  button :ingest_button

  VCR.use_cassette 'ingest page elements' do
    define_page_elements(CreateIngestAssetWebserviceClient.new)
  end

  # Complete form for Ingestion
  #
  # @param asset [VideoAsset]
  def create_ingestion(asset=FactoryGirl.build(:default_mio_video_asset))
    clip_description_element.when_present.value = asset.description
    interviewee_element.when_present.value = asset.interviewee
    freelance_producer_element.when_present.value = asset.freelance_producer
    reporter_1_element.when_present.value = asset.reporter_writer_1
    error_logger :warn, 'Bug on restrictions buttons: can\'t access at present'
    ingest_button
    error_logger :warn, 'Assert not yet possible on Ingest page'
  end

end
