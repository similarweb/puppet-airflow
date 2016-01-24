require 'spec_helper'
describe 'airflow' do

  context 'with defaults for all parameters' do
    it { should contain_class('airflow') }
  end
end
