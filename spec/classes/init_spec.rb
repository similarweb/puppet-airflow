require 'spec_helper'
describe 'airflow', :type => :class do

  context 'with defaults for all parameters' do
    on_supported_os.each do |os, facts|
      let(:facts) { facts }
      it { is_expected.to contain_class('airflow') }
      it { is_expected.to contain_python__pip('apache-airflow') }
    end
  end
end
