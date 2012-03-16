ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# for devise
class ActionController::TestCase
  include Devise::TestHelpers
end

# for strip_attributes
require "strip_attributes/shoulda"
class Test::Unit::TestCase
  extend StripAttributes::Shoulda::Macros
end

# disable sunspot during tests
Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
