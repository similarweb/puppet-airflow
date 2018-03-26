require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|
  c.hiera_config = 'spec/fixtures/hieradata/hiera.yaml'
  c.before(:each) do
    if defined?(hieradata)
      set_hieradata(hieradata.gsub(':','_'))
    else
      set_hieradata(nil)
    end
  end
end

def set_hieradata(hieradata)
  RSpec.configure { |c| c.default_facts['custom_hiera'] = hieradata }
end
