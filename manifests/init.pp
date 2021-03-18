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
# [*remote_log_conn_id*]
#   A connection to use to access remote_base_log_folder
#   Will enable `remote_logging` if provided
# [*remote_base_log_folder*]
#   A remote location can be provided for log backups
#   For S3, use the full URL to the base folder (starting with "s3://...").
# [*logging_level*]
#   Logging level
# [*extra_log_config*]
#   Additional configuration to be set up. Takes a dictionary of formatters,
#   handlers and loggers.
#   For documentation see links. Adjust for installed version.
#   https://airflow.apache.org/docs/apache-airflow/stable/logging-monitoring/logging-tasks.html
#   https://github.com/apache/airflow/blob/v1-10-stable/airflow/config_templates/airflow_local_settings.py
# [*executor*]
#   The executor class that airflow should use, defaults to `CeleryExecutor`.
# [*sql_alchemy_conn*]
#   The SQLAlchemy connection string to the metadata database.
# [*sql_alchemy_pool_size*]
#   The SqlAlchemy pool size is the maximum number of database connections in
#   the pool. 0 indicates no limit.
# [*sql_alchemy_max_overflow*]
#   The maximum overflow size of the pool.
# [*sql_alchemy_pool_recycle*]
#   The number of seconds a connection can be idle in the pool before it is
#   invalidated.
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
# [*hostname_callable*]
#   Hostname by providing a path to a callable, which will resolve the hostname.
#   The format is "package.function".
# [*dagbag_import_timeout*]
#   How long before timing out a python file import.
# [*dag_file_processor_timeout*]
#   How long before timing out a DagFileProcessor, which processes a dag file.
###### Webserver settings ######
# [*base_url*]
#   The base url of your website as airflow cannot guess what domain or
#   cname you are using. This is use in automated emails that
#   airflow sends to point links to the right web server.
# [*proxy_fix*]
#   To ensure that Airflow generates URLs with the correct scheme when running
#   behind a TLS-terminating proxy, you should configure the proxy to set the
#   X-Forwarded-Proto header, and enable this.
#   Note: You should only enable the ProxyFix middleware when running Airflow
#         behind a trusted proxy (AWS ELB, nginx, etc.).
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
#   https://airflow.apache.org/security.html#rbac-ui-security
# [*auth_backend*]
#   Airflow Authentication Backend, for example LDAP.
# [*auth_details*]
#   Authentication settings. It could be a hash (LDAP), or an array of hashes,
#   such as for OAUTH and OPENID, which accept multiple services.
# [*auth_user_registration_role*]
#   Self-registration role. Only if this is set, users will be allowed to
#   register themselves. Should be enabled with OAUTH(and maybe others?), unless
#   you know the correct information to input.
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
# [*worker_concurrency*]
#   The concurrency that will be used when starting workers with the
#   "airflow worker" command.
# [*worker_autoscale*]
#   The maximum and minimum concurrency that will be used when starting workers
#   with the "airflow worker" command.
#   Overrides *worker_concurrency*.
# [*worker_log_server_port*]
#   When you start an airflow worker, airflow starts a tiny web server
#   subprocess to serve the workers local log files to the airflow main
#   web server.
# [*broker_url*]
#   The celery broker URL.
# [*result_backend*]
#   The celery result backend setting.
# [*flower_port*]
#   Celery flower is a sweet UI for celery.
# [*flower_url_prefix*]
#   Root prefix for Flower, if it's behind the same proxy as Airflow.
# [*default_queue*]
#   Default queue that tasks get assigned to and that worker listen on.
###### Scheduler settings ######
###### Scheduler settings ######
#  [*catchup*]
# Turn off scheduler catchup by setting this to False.
# Default behavior is unchanged and
# Command Line Backfills still work, but the scheduler
# will not do scheduler catchup if this is False,
# however it can be set on a per DAG basis in the
# [*dag_dir_list_interval*]
#   How often (in seconds) to scan the DAGs directory for new files. Default
#   to 5 minutes.
# [*job_heartbeat_sec*]
#   Task instances listen for external kill signal (when you clear tasks
#   from the CLI or the UI), this defines the frequency at which they should
#   listen (in seconds).
# [*print_stats_interval*]
#   How often should stats be printed to the logs. Setting to 0 will disable
#   printing stats
# [*scheduler_heartbeat_sec*]
#   The scheduler constantly tries to trigger new tasks (look at the
#   scheduler section in the docs for more information). This defines
#   how often the scheduler should run (in seconds).
###### Puppet hashes ######
# [*statsd_settings*]
#   Statsd settings dictionary.
# [*mesos_settings*]
#   mesos settings dictionary.

# === Authors
# Production Engineering SimilarWeb
# Copyright 2016 SimilarWeb.
#
class airflow (
  # {Params}
  # Airflow service settings
  $service_ensure,
  $service_enable,

  # Airflow install settings
  $version,
  $package_name,
  $manage_install,
  $virtualenv,
  $requirements,
  $python,

  # User and group settings
  $user,
  $group,
  $folders_mode,

  # General settings
  $log_folder,
  $run_folder,

  # Airflow.cfg file
  ## Core settings
  $home_folder,
  $dags_folder,
  $remote_log_conn_id,
  $remote_base_log_folder,
  $logging_level,
  $extra_log_config,
  $executor,
  $sql_alchemy_conn,
  $sql_alchemy_pool_size,
  $sql_alchemy_max_overflow,
  $sql_alchemy_pool_recycle,
  $parallelism,
  $dag_concurrency,
  $max_active_runs_per_dag,
  $load_examples,
  $fernet_key,
  $donot_pickle,
  $hostname_callable,
  $plugins_folder,
  $dagbag_import_timeout,
  $dag_file_processor_timeout,

  ## Webserver settings
  $base_url,
  $proxy_fix,
  $web_server_host,
  $web_server_port,
  $secret_key,
  $gunicorn_workers,
  $worker_class,
  $expose_config,
  $authenticate,
  $auth_backend,
  $auth_user_registration_role,

  $filter_by_owner,
  $log_fetch_timeout_sec,

  ## Mail settings
  $smtp_host,
  $smtp_starttls,
  $smtp_user,
  $smtp_port,
  $smtp_password,
  $smtp_mail_from,

  ## Celery settings
  $celery_app_name,
  $worker_concurrency,
  $worker_autoscale,
  $worker_log_server_port,
  $broker_url,
  $result_backend,
  $flower_port,
  $flower_url_prefix,
  $default_queue,

  ## Scheduler settings
  $catchup,
  $dag_dir_list_interval,
  $job_heartbeat_sec,
  $print_stats_interval,
  $scheduler_heartbeat_sec,
  $scheduler_max_threads,
  $statsd_settings,
  $auth_details,
  $mesos_settings,
  $run_duration,

  ## Log level override settings
  $scheduler_log_level,
  $webserver_log_level,
  $worker_log_level,
) {
  validate_string($user)
  validate_string($group)
  validate_string($service_ensure)
  validate_string($package_name)
  validate_string($virtualenv)
  validate_string($worker_class)
  validate_string($folders_mode)
  validate_string($flower_url_prefix)
  validate_string($hostname_callable)
  validate_string($logging_level)
  validate_string($remote_log_conn_id)
  validate_string($remote_base_log_folder)
  validate_string($scheduler_log_level)
  validate_string($webserver_log_level)
  validate_string($worker_log_level)

  validate_absolute_path($log_folder)
  validate_absolute_path($run_folder)
  validate_absolute_path($home_folder)
  validate_absolute_path($dags_folder)
  validate_absolute_path($plugins_folder)

  validate_integer($sql_alchemy_pool_size)
  validate_integer($sql_alchemy_max_overflow)
  validate_integer($sql_alchemy_pool_recycle)
  validate_integer($parallelism)
  validate_integer($dag_concurrency)
  validate_integer($max_active_runs_per_dag)
  validate_integer($dag_dir_list_interval)
  validate_integer($dagbag_import_timeout)
  validate_integer($dag_file_processor_timeout)
  validate_integer($job_heartbeat_sec)
  validate_integer($log_fetch_timeout_sec)
  validate_integer($print_stats_interval)
  validate_integer($run_duration)
  validate_integer($scheduler_heartbeat_sec)
  validate_integer($scheduler_max_threads)
  validate_integer($web_server_port)
  validate_integer($worker_concurrency)
  validate_integer($worker_log_server_port)
  validate_integer($flower_port)
  validate_integer($smtp_port)

  validate_re($worker_autoscale, ['^UNDEFINED$', '^[0-9]+,[0-9]+$'], "Airflow[${name}]: worker_autoscale must be of the format max,min")

  validate_bool($proxy_fix)
  validate_bool($service_enable)
  validate_bool($authenticate)
  validate_bool($filter_by_owner)
  validate_bool($expose_config)
  validate_bool($load_examples)
  validate_bool($donot_pickle)
  validate_bool($catchup)

  contain airflow::config
  contain airflow::install
}
