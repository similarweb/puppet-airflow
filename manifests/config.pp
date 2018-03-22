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
    require => Python::Pip[$airflow::package_name],
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
    require =>  [Python::Pip[$airflow::package_name], File[$airflow::home_folder]]
  }
}
