# frozen_string_literal: true
# Params solution is temporary: login page will be separate in the final rendered panels

When(/^I log in(?: to the browser panel)?$/) do
  visit FTLoginPage, using_params: {panel: 'browser'}, &:log_in
  expect((on ProjectPage).logged_in?).to be_truthy, 'Login failed'
end

When(/^I log in to the prelude panel$/) do
  visit FTLoginPage, using_params: {panel: 'prelude'}, &:log_in
end

When(/^I log in to the premiere panel$/) do
  visit FTLoginPage, using_params: {panel: 'premiere'}, &:log_in
end

When(/^I log in with an invalid account$/) do
  (visit FTLoginPage, using_params: {panel: 'browser'}).log_in(username: 'FAILED', password: 'failed')
end

Then(/^I cannot log in$/) do
  expect((on ProjectPage).logged_in?).to be_falsey, 'Login allowed with invalid credentials'
end
