# frozen_string_literal: true
When(/^I create a project$/) do
  visit FTLoginPage, using_params: {panel: 'browser'}, &:log_in
  (on ProjectPage).create_project('12345')
  expect((on ProjectPage).submit_successful?).to be_truthy
end

When(/^I create a project with invalid values$/) do
  visit FTLoginPage, using_params: {panel: 'browser'}, &:log_in
  (on ProjectPage).create_project('')
  expect(@browser.div(id:'react-app').html).to match /status__message status__message--error/
end
