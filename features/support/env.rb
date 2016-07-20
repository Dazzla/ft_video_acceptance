# frozen_string_literal: true
require 'cucumber'
require 'watir-webdriver'
require 'rspec/expectations'
require 'page-object'
require 'test-unit'
require 'yaml'
require 'factory_girl'
require 'byebug'
require 'rotp'


require_relative '../../lib/pages/panel_page'
require_relative '../../lib/pages/mio_login_page'
require_relative '../../lib/pages/mio_dashboard_page'
require_relative '../../config/config'
require_relative '../../lib/pages/in_development/ft_login_page'
require_relative '../../lib/pages/in_development/project_page'
require_relative '../../lib/pages/in_development/ingest_page'
require_relative '../../lib/pages/in_development/publish_video_page'

World(PageObject::PageFactory)
World(FactoryGirl::Syntax::Methods)
World(Config)
World(ROTP)
