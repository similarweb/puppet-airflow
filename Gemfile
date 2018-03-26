source 'https://rubygems.org'

gem 'puppet', ENV.fetch('PUPPET_GEM_VERSION', '>= 3.3')
gem 'facter', ENV.fetch('FACTER_GEM_VERSION', '>= 1.7.0'), :require => false
group :development, :test do
  gem 'rake',                          :require => false
  gem 'puppetlabs_spec_helper',        :require => false
  gem 'puppet-lint', '>= 1.1.0',       :require => false
  gem 'puppet-syntax',                 :require => false
  gem 'rspec-puppet', '~> 2.2',        :require => false
  gem 'rspec-puppet-facts', '~> 1.7',  :require => false
  gem 'metadata-json-lint',            :require => false
end
