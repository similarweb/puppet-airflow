require 'spec_helper'
describe 'airflow', type: :class do
  on_supported_os.each do |_os, facts|
    let(:facts) { facts }
    context 'with defaults for all parameters' do
      it { is_expected.to contain_class('airflow') }
      it { should contain_python__virtualenv('airflow') }
      it { is_expected.to contain_python__pip('apache-airflow') }
    end

    context 'with virtualenv requirements' do
      let(:params) { { requirements: 'requirements.txt' } }
      it { is_expected.to contain_class('airflow') }
      it { is_expected.to contain_python__virtualenv('airflow') }
      it { is_expected.to_not contain_python__pip('apache-airflow') }
    end

    context 'with virtualenv requirements in hiera' do
      let(:hieradata) { 'reqs' }
      it { should compile }
      it { is_expected.to contain_class('airflow') }
      it { is_expected.to contain_python__virtualenv('airflow') }
      it { is_expected.to_not contain_python__pip('apache-airflow') }
    end

    context 'with authentication' do
      let(:params) {
        {
          authenticate: true,
          auth_backend: 'OPENID',
          auth_details: [{ name: 'Yahoo', url: 'https://me.yahoo.com' }],
        }
      }
      it { should compile }
      it { is_expected.to contain_class('airflow') }
    end
  end
end
