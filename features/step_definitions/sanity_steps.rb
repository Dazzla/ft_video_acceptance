# frozen_string_literal: true
When(/^I log in to Mio$/) do
  (visit MioLoginPage).log_in
  expect((on MioDashboardPage).displayed?).to be_truthy, 'Login failed'
end

When(/^I can access (\w+) features$/) do |section|
  expect((on MioDashboardPage)
    .change_section(section))
    .to be_truthy, "Failed to change to section #{section}"
end
