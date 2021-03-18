# define: airflow::resource::service
# == Description: Creates a systemd service definition 
#
define airflow::resource::service($service_name = $name) {
  $cmd_path = "/home/${airflow::user}/venv/${airflow::virtualenv}"
  systemd::unit_file { "${service_name}.service":
    ensure  => 'file',
    content => template("${module_name}/${service_name}.service.erb"),
    notify  => Service[$service_name],
    require => [Class[airflow::install], File[$airflow::log_folder]]
  }
  $auth_dependency = $airflow::authenticate ? {
    true    => [File["${airflow::home_folder}/webserver_config.py"]],
    default => [],
  }
  $logging_dependency = $airflow::extra_log_config ? {
    true    => [File["${airflow::home_folder}/config/log_config.py"]],
    default => [],
  }

  service { $service_name:
    ensure    => $airflow::service_ensure,
    enable    => $airflow::service_enable,
    require   => [Exec['systemctl-daemon-reload']],
    subscribe => [
      Systemd::Unit_file["${service_name}.service"],
      File["${airflow::home_folder}/airflow.cfg"],
    ] + $auth_dependency + $logging_dependency
  }
}
