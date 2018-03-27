require 'spec_helper'
describe 'airflow::service::scheduler', :type => :class do

  context 'with defaults for all parameters' do
    on_supported_os.each do |os, facts|
      let(:facts) { facts }
      it { should compile }
      it { is_expected.to contain_class('airflow::service::scheduler') }
    end
  end

  context 'with virtualenv requirements' do
    on_supported_os.each do |os, facts|
      let(:facts) { facts }
      let(:hieradata) { 'reqs' }
      it { should compile }
      it { is_expected.to contain_class('airflow::service::scheduler') }
      it { is_expected.to contain_systemd__unit_file('airflow-scheduler.service') }
      it do
        is_expected.to contain_file('/etc/systemd/system/airflow-scheduler.service') \
          .with_content(%r'^ExecStart=/home/airflow/venv/airflow/bin/airflow scheduler$')
      end
    end
  end
end

