# frozen_string_literal: true
require_relative '../../test/data/publish_video'
require 'factory_girl'

FactoryGirl.define do
  factory :publish_video, class: PublishVideo do |video|
    video.section 'World & Economy'
    video.brand 'Markets and Investing'
    video.headline 'Read This Story'
    video.long_lead 'Long Lead'
    video.short_lead 'Short Lead'
    video.related_content 'http://www.example/com'
    video.credit 'Robert Nozick'
    video.video_editor 'Sophie Cohen'
    video.freelance_video_editor 'Werner Heisenberg'
  end
end
