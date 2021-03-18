require 'spec_helper'
describe 'airflow', type: :class do
  on_supported_os.each do |_os, facts|
    let(:facts) { facts }
    context 'with defaults for all parameters' do
      it { is_expected.to contain_class('airflow') }
      it { should contain_python__pyvenv('airflow') }
      it { is_expected.to contain_python__pip('apache-airflow') }
      it { should contain_file("/opt/airflow/airflow.cfg").with_content(/max_threads = 4/) }
      it { should_not contain_file("/opt/airflow/config/log_config.py") }
    end

    context 'with virtualenv requirements' do
      let(:params) { { requirements: 'requirements.txt' } }
      it { is_expected.to contain_class('airflow') }
      it { is_expected.to contain_python__pyvenv('airflow') }
      it { is_expected.to_not contain_python__pip('apache-airflow') }
    end

    context 'with virtualenv requirements in hiera' do
      let(:hieradata) { 'reqs' }
      it { should compile }
      it { is_expected.to contain_class('airflow') }
      it { is_expected.to contain_python__pyvenv('airflow') }
      it { is_expected.to_not contain_python__pip('apache-airflow') }
    end

    context 'with virtualenv requirements but disabled install management' do
      let(:params) { { requirements: 'requirements.txt', manage_install: false } }
      it { should compile }
      it { is_expected.to contain_class('airflow') }
      it { is_expected.to_not contain_python__pyvenv('airflow') }
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

    context 'with log extras' do
      let(:params) {
        {
          extra_log_config: {
            "loggers": {
              "botocore": { "level": "WARNING", "handlers": ["console"], "propagate": false },
              "boto3": { "level": "WARNING", "handlers": ["console"], "propagate": false },
              "s3transfer": { "level": "WARNING", "handlers": ["console"], "propagate": false },
            }
          }
        }
      }
      it { should compile }
      it { is_expected.to contain_class('airflow') }
      it do
        is_expected.to contain_file('/opt/airflow/config/log_config.py') \
          .with_content(/"s3transfer":{"level":"WARNING","handlers":\["console"\],"propagate":false}/)
      end
    end
  end
end
