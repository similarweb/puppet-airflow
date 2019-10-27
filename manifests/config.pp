#== Class: airflow::config
# == Description: Manages the following resources:user,group,directories tree,
# AIRFLOW_HOME environment variable and airflow.cfg file. 
#
class airflow::config inherits airflow {
  # Create airflow folders
  $airflow_app_folders =
  [
    $airflow::log_folder,$airflow::run_folder,
    $airflow::dags_folder,$airflow::plugins_folder
  ]
  file { $airflow::home_folder:
    ensure  => directory,
    owner   => $airflow::user,
    group   => $airflow::group,
    mode    => $airflow::folders_mode,
    require => Class[airflow::install],
    recurse => true
  }
  file { $airflow_app_folders:
    ensure  => directory,
    owner   => $airflow::user,
    group   => $airflow::group,
    mode    => $airflow::folders_mode,
    require => File[$airflow::home_folder]
  }
  # Setup airflow.cfg configuration file
  file { "${airflow::home_folder}/airflow.cfg":
    ensure  => 'file',
    content => template("${module_name}/airflow.cfg.erb"),
    mode    => '0755',
    require =>  [Class[airflow::install], File[$airflow::home_folder]]
  }
  if $airflow::authenticate {
    # Setup webserver_config.py for RBAC
    file { "${airflow::home_folder}/webserver_config.py":
      ensure  => 'file',
      content => template("${module_name}/webserver_config.py.erb"),
      mode    => '0755',
      require =>  [Class[airflow::install], File[$airflow::home_folder]]
    }
  }
}
