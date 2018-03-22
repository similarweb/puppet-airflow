require 'spec_helper'
describe 'airflow::service::scheduler', :type => :class do

  context 'with defaults for all parameters' do
    on_supported_os.each do |os, facts|
      let(:facts) { facts }
      it { should compile }
      it { is_expected.to contain_class('airflow::service::scheduler') }
    end
  end
end

