#== Class: airflow::config
# == Description: Manages the following resources:user,group,directories tree,
# AIRFLOW_HOME environment variable and airflow.cfg file. 
#
class airflow::config inherits airflow {
  # Create user and group
  group { $airflow::group:
    ensure => 'present',
    name   => $airflow::group,
    gid    => $airflow::gid,
  } ->
  user { $airflow::user:
    ensure     => 'present',
    shell      => $airflow::shell,
    managehome => true,
    uid        => $airflow::uid,
    gid        => $airflow::group
  }
  # Create airflow base home folders
  file { $airflow::home_folder:
    ensure  => directory,
    owner   => $airflow::user,
    group   => $airflow::group,
    mode    => $airflow::folders_mode,
    require => Python::Pip[$airflow::package_name],
    recurse => true
  }
  # Create airflow folders
  $airflow_folders =
  [
    $airflow::log_folder,$airflow::run_folder,
    $airflow::dags_folder,$airflow::plugins_folder
  ]
  file { $airflow_folders:
    ensure  => directory,
    owner   => $airflow::user,
    group   => $airflow::group,
    mode    => $airflow::folders_mode,
    require => File[$airflow::home_folder]
  }
  # Set the AIRFLOW_HOME environment variable on the server
  file { "${airflow::user_home_folder}/.bash_profile":
    content => inline_template("AIRFLOW_HOME=${airflow::home_folder}")
  }
  # Setup airflow.cfg configuration file
  file { "${airflow::home_folder}/airflow.cfg":
    ensure  => 'file',
    content => template("${module_name}/airflow.cfg.erb"),
    mode    => '0755',
    require =>  Python::Pip[$airflow::package_name]
  }
}