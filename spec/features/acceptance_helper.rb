require 'rails_helper'

RSpec.configure do |config|

  config.include AcceptanceHelper, type: :feature

  config.use_transactional_fixtures = false

  Capybara.javascript_driver = :poltergeist

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
    end
  end
end
