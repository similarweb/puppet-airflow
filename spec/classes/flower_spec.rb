require 'spec_helper'
describe 'airflow::service::flower', :type => :class do
  on_supported_os.each do |_os, facts|
    let(:facts) { facts }

    context 'with defaults for all parameters' do
      it { should compile }
      it { is_expected.to contain_class('airflow::service::flower') }
    end

    context 'with virtualenv requirements' do
      let(:hieradata) { 'reqs' }
      it { should compile }
      it { should contain_class('airflow::service::flower') }
      it { should_not contain_python__pip('apache-airflow') }
    end
  end
end
