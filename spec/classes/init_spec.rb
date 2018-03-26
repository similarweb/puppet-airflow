require 'spec_helper'
describe 'airflow', :type => :class do

  context 'with defaults for all parameters' do
    on_supported_os.each do |os, facts|
      let(:facts) { facts }
      it { should contain_class('airflow') }
    end
  end
end
