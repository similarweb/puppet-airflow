# == Class: airflow
#
# Installs, configures and manages airflow
#
# === Parameters
###### Airflow install settings ######
# [*version*]
#   Specify version of airflow pip package to download, defaults to `1.6.2`.
# [*package_name*]
#   Package name, defaults to `airflow`.
###### General settings ######
# [*log_folder*]
#  The folder where airflow's logs are located, defaults to `/var/log/airflow`.
# [*run_folder*]
#  The folder where airflow's pid file is located,
#  defaults to `/var/run/airflow`.
###### Core settings ######
# [*home_folder*]
#   The home folder for airflow, defaults to `/opt/airflow`.
# [*dags_folder*]
#   The folder where your airflow pipelines live,
#   defaults to `/opt/airflow/dags`.
# [*s3_log_folder*]
#   An S3 location can be provided for log backups
#   For S3, use the full URL to the base folder (starting with "s3://...").
# [*executor*]
#   The executor class that airflow should use, defaults to `CeleryExecutor`.
# [*sql_alchemy_conn*]
#   The SQLAlchemy connection string to the metadata database.
# [*parallelism*]
#   The amount of parallelism as a setting to the executor,
#   defaults to `32`.
# [*dag_concurrency*]
#   The number of task instances allowed to run concurrently by the scheduler.
# [*max_active_runs_per_dag*]
#   The maximum number of active DAG runs per DAG.
# [*load_examples*]
#   Whether to load the examples that ship with airflow,
#   default to `true`.
# [*plugins_folder*]
#   Where your Airflow plugins are stored, defaults to `/opt/airflow/plugins`.
# [*fernet_key*]
#   Secret key to save connection passwords in the db.
# [*donot_pickle*]
#   Whether to disable pickling dags.
###### Webserver settings ######
# [*base_url*]
#   The base url of your website as airflow cannot guess what domain or
#   cname you are using. This is use in automated emails that
#   airflow sends to point links to the right web server.
# [*web_server_host*]
#   The ip specified when starting the web server.
# [*web_server_port*]
#   The port on which to run the web server.
# [*secret_key*]
#   Secret key used to run your flask app.
# [*gunicorn_workers*]
#   Number of workers to run the Gunicorn web server.
# [*worker_class*]
#   The worker class gunicorn should use. Choices include
#   sync (default), eventlet, gevent.
# [*expose_config*]
#   Expose the configuration file in the web server.
# [*authenticate*]
#   Set to true to turn on authentication.
#   http://pythonhosted.org/airflow/installation.html#web-authentication
# [*auth_backend*]
#   Airflow Authentication Backend, for example LDAP.
# [*filter_by_owner*]
#   Filter the list of dags by owner name
#   (requires authentication to be enabled).
###### Mail settings ######
# [*smtp_host*]
#   Smtp host, defaults to `localhost`.
# [*smtp_starttls*]
#   Use tls for smtp, defaults to `true`.
# [*smtp_user*]
#   Smtp user, defaults to `airflow`.
# [*smtp_port*]
#   Smtp port, defaults to `25`.
# [*smtp_password*]
#   Smtp password, defaults to `airflow`.
# [*smtp_mail_from*]
#   Airflow from email address, defaults to `airflow@airflow.com`.
###### Celery settings ######
# [*celery_app_name*]
#   The app name that will be used by celery.
# [*celeryd_concurrency*]
#   The concurrency that will be used when starting workers with the
#   "airflow worker" command.
# [*worker_log_server_port*]
#   When you start an airflow worker, airflow starts a tiny web server
#   subprocess to serve the workers local log files to the airflow main
#   web server.
# [*broker_url*]
#   The celery broker URL.
# [*celery_result_backend*]
#   The celery result backend setting.
# [*flower_port*]
#   Celery flower is a sweet UI for celery.
# [*default_queue*]
#   Default queue that tasks get assigned to and that worker listen on.
###### Scheduler settings ######
# [*job_heartbeat_sec*]
#   Task instances listen for external kill signal (when you clear tasks
#   from the CLI or the UI), this defines the frequency at which they should
#   listen (in seconds).
# [*scheduler_heartbeat_sec*]
#   The scheduler constantly tries to trigger new tasks (look at the
#   scheduler section in the docs for more information). This defines
#   how often the scheduler should run (in seconds).
###### Puppet hashes ######
# [*statsd_settings*]
#   Statsd settings dictionary.
# [*ldap_settings*]
#   ldap settings dictionary.
# [*mesos_settings*]
#   mesos settings dictionary.

# === Authors
# Production Engineering SimilarWeb
# Copyright 2016 SimilarWeb.
#
class airflow (
  # {Params}
  # Airflow service settings
  $service_ensure          = $airflow::params::service_ensure,
  $service_enable          = $airflow::params::service_enable,

  # Airflow install settings
  $version                 = $airflow::params::version,
  $package_name            = $airflow::params::package_name,

  # User and group settings
  $user                    = $airflow::params::user,
  $group                   = $airflow::params::group,
  $user_home_folder        = $airflow::params::user_home_folder,
  $shell                   = $airflow::params::shell,
  $folders_mode            = $airflow::params::folders_mode,
  $gid                     = $airflow::params::gid,
  $uid                     = $airflow::params::uid,

  # General settings
  $log_folder              = $airflow::params::log_folder,
  $run_folder              = $airflow::params::run_folder,
  $systemd_service_folder  = $airflow::params::systemd_service_folder,

  # Airflow.cfg file
  ## Core settings
  $home_folder             = $airflow::params::home_folder,
  $dags_folder             = $airflow::params::dags_folder,
  $s3_log_folder           = $airflow::params::s3_log_folder,
  $executor                = $airflow::params::executor,
  $sql_alchemy_conn        = $airflow::params::sql_alchemy_conn,
  $parallelism             = $airflow::params::parallelism,
  $dag_concurrency         = $airflow::params::dag_concurrency,
  $max_active_runs_per_dag = $airflow::params::max_active_runs_per_dag,
  $load_examples           = $airflow::params::load_examples,
  $fernet_key              = $airflow::params::fernet_key,
  $donot_pickle            = $airflow::params::donot_pickle,
  $plugins_folder          = $airflow::params::plugins_folder,

  ## Webserver settings
  $base_url                = $airflow::params::base_url,
  $web_server_host         = $airflow::params::web_server_host,
  $web_server_port         = $airflow::params::web_server_port,
  $secret_key              = $airflow::params::secret_key,
  $gunicorn_workers        = $airflow::params::gunicorn_workers,
  $worker_class            = $airflow::params::worker_class,
  $expose_config           = $airflow::params::expose_config,
  $authenticate            = $airflow::params::authenticate,
  $auth_backend            = $airflow::params::auth_backend,
  $filter_by_owner         = $airflow::params::filter_by_owner,

  ## Mail settings
  $smtp_host               = $airflow::params::smtp_host,
  $smtp_starttls           = $airflow::params::smtp_starttls,
  $smtp_user               = $airflow::params::smtp_user,
  $smtp_port               = $airflow::params::smtp_port,
  $smtp_password           = $airflow::params::smtp_password,
  $smtp_mail_from          = $airflow::params::smtp_mail_from,

  ## Celery settings
  $celery_app_name         = $airflow::params::celery_app_name,
  $celeryd_concurrency     = $airflow::params::celeryd_concurrency,
  $worker_log_server_port  = $airflow::params::worker_log_server_port,
  $broker_url              = $airflow::params::broker_url,
  $celery_result_backend   = $airflow::params::celery_result_backend,
  $flower_port             = $airflow::params::flower_port,
  $default_queue           = $airflow::params::default_queue,

  ## Scheduler settings
  $job_heartbeat_sec       = $airflow::params::job_heartbeat_sec,
  $scheduler_heartbeat_sec = $airflow::params::scheduler_heartbeat_sec,

  ### START hiera lookups ###
  $statsd_settings         = $airflow::params::statsd_settings,
  $ldap_settings           = $airflow::params::ldap_settings,
  $mesos_settings          = $airflow::params::mesos_settings,
  ### END hiera lookups ###

) inherits airflow::params {

  validate_string($user)
  validate_string($group)
  validate_string($service_ensure)
  validate_string($package_name)
  validate_string($worker_class)

  validate_absolute_path($user_home_folder)
  validate_absolute_path($shell)
  validate_absolute_path($log_folder)
  validate_absolute_path($run_folder)
  validate_absolute_path($home_folder)
  validate_absolute_path($dags_folder)
  validate_absolute_path($plugins_folder)

  validate_integer($folders_mode)

  if $gid != undef {
    validate_integer($gid)
  }

  if $uid != undef {
    validate_integer($uid)
  }

  validate_integer($parallelism)
  validate_integer($dag_concurrency)
  validate_integer($max_active_runs_per_dag)
  validate_integer($job_heartbeat_sec)
  validate_integer($scheduler_heartbeat_sec)
  validate_integer($web_server_port)
  validate_integer($celeryd_concurrency)
  validate_integer($worker_log_server_port)
  validate_integer($flower_port)
  validate_integer($smtp_port)

  validate_bool($service_enable)
  validate_bool($authenticate)
  validate_bool($filter_by_owner)
  validate_bool($expose_config)
  validate_bool($load_examples)
  validate_bool($donot_pickle)

  # Module compatibility check
  if ! ($::operatingsystem in ['RedHat', 'CentOS']
    and $::operatingsystemmajrelease == '7')
  {
      fail("Module is not compatible with
       ${::operatingsystem} Release: ${::operatingsystemmajrelease}")
  }

  include airflow::config,
          airflow::install

}
