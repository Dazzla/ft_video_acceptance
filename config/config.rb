# frozen_string_literal: true
require 'yaml'
require 'rotp'

module Config

  module Logging

    ERROR_LOG = $stderr
    INFO_LOG = File.new((File.expand_path(File.join(File.dirname(__FILE__), 'logs.txt'))), 'w+')


    def info_logger(level, message)
      Logger.new(INFO_LOG).method(level).call(message)
    end

    def error_logger(level, message)
      #Logger.new(ERROR_LOG).method(level).call(message)
    end

  end

  module Constants

    EXECUTION_ENVIRONMENT ||= :dev
    REPORTS ||= '../../reports'
    CONFIG ||= YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), 'master.yml')))
    ENVIRONMENT_CONFIG ||= CONFIG[EXECUTION_ENVIRONMENT]
    MIO_ROOT_URL ||= ENVIRONMENT_CONFIG[:url]
    MIO_WS_URL ||= ENVIRONMENT_CONFIG[:ws_url]
    FT_ROOT_URL ||= ENVIRONMENT_CONFIG[:url]
    ADMIN_USER ||= ENVIRONMENT_CONFIG[:admin_user]
    PANEL_ID ||= ENVIRONMENT_CONFIG[:panel_id]
    DEFAULT_SECTION = 'http://api.ft.com/things/12bcffe1-f9f1-47ce-a3aa-e2dcdfaf7499'
    DEFAULT_BRAND = 'http://api.ft.com/things/d4991c65-5e03-471c-bbba-fdb20d9d1009'
    HTTP_SUCCESS_CODES = (200...299)
    WAIT_DELAY = 5
    ASSET_PATH = 'b0778312-7686-49bc-a720-0551709ad37b/Missing.mp4'
    ASSET_TITLE = 'Missing.mp4'
    ASSET_UUID = 'b0778312-7686-49bc-a720-0551709ad37b'
    ASSET_URL = 'https://api.ft.com/thing/5d24e298-c1da-4831-8332-74941875a159'
    PROJECT_METADATA_NAME = ENVIRONMENT_CONFIG[:project_metadata_name]
    INGEST_METADATA_NAME = ENVIRONMENT_CONFIG[:ingest_metadata_name]
    PUBLISH_METADATA_NAME = ENVIRONMENT_CONFIG[:publish_metadata_name]
    OTP = ROTP::TOTP.new(ENV['MIO_APP_KEY'])
  end

end
