#== Class: airflow::params
#
#
class airflow::params {
  # Airflow service settings
  $service_ensure            = 'running'
  $service_enable            = true

  # Airflow install settings
  $version                   = '1.6.2'
  $package_name              = 'airflow'

  # User and group settings
  $user                      = 'airflow'
  $group                     = 'airflow'
  $user_home_folder          = "/home/${user}"
  $shell                     = '/bin/bash'
  $gid                       = undef
  $uid                       = undef
  $folders_mode              = '0775'

  # General settings
  $log_folder                = '/var/log/airflow'
  $run_folder                = '/var/run/airflow'
  $systemd_service_folder    = '/lib/systemd/system'

  # Airflow.cfg file
  ## Core settings
  $home_folder               = '/opt/airflow'
  $dags_folder               = "${home_folder}/dags"
  $s3_log_folder             = 'None'
  $executor                  = 'CeleryExecutor'
  $sql_alchemy_conn          = "sqlite:////${home_folder}/airflow.db"
  $parallelism               = 32
  $dag_concurrency           = 16
  $max_active_runs_per_dag   = 16
  $load_examples             = false
  $plugins_folder            = "${home_folder}/plugins"
  $fernet_key                =
    'cryptography_not_found_storing_passwords_in_plain_text'
  $donot_pickle              = false

  ## Webserver settings
  $base_url                  = 'http://localhost'
  $web_server_host           = '0.0.0.0'
  $web_server_port           = 8080
  $secret_key                = 'temporary_key'
  $gunicorn_workers          = 4
  $worker_class              = 'sync'
  $expose_config             = true
  $authenticate              = false
  $auth_backend              = undef
  $filter_by_owner           = false

  ## Mail settings
  $smtp_host                 = 'localhost'
  $smtp_starttls             = true
  $smtp_user                 = 'airflow'
  $smtp_port                 = 25
  $smtp_password             = 'airflow'
  $smtp_mail_from            = 'airflow@airflow.com'

  ## Celery settings
  $celery_app_name           = 'airflow.executors.celery_executor'
  $celeryd_concurrency       = 16
  $worker_log_server_port    = 8793
  $broker_url                = 'sqla+mysql://airflow:airflow@localhost:3306/airflow'
  $celery_result_backend     = 'db+mysql://airflow:airflow@localhost:3306/airflow'
  $flower_port               = 5555
  $default_queue             = 'default'

  ## Scheduler settings
  $catchup                   = false
  $job_heartbeat_sec         = 5
  $scheduler_heartbeat_sec   = 5

  ### START hiera lookups ###
  $ldap_settings             = {}
  $statsd_settings           = {}
  $mesos_settings            = {}
  ### END hiera lookups ###
}
