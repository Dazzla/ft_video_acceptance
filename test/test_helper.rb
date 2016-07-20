# frozen_string_literal: true
 require 'factory_girl'
 require 'minitest/ci'
 require_relative '../config/config'
 require_relative '../vcr_setup'
 require_relative '../test/factories/video_asset_factory'
 require_relative '../test/factories/video_project_factory'
 require_relative '../test/factories/publish_video_factory'
 require_relative '../test/data/video_asset'
 require_relative 'video_test'
 require_relative '../test/data/publish_video'
 require_relative '../config/config'

 Minitest::Ci.clean = false
