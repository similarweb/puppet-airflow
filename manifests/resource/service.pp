# define: airflow::resource::service
# == Description: Creates a systemd service definition 
#
define airflow::resource::service($service_name = $name) {
  systemd::unit_file { "${service_name}.service":
    ensure  => 'file',
    content => template("${module_name}/${service_name}.service.erb"),
    notify  => Service[$service_name],
    require => [Python::Pip[$airflow::package_name], File[$airflow::log_folder]]
  }
  service { $service_name:
    ensure    => $airflow::service_ensure,
    enable    => $airflow::service_enable,
    require   => [Exec['systemctl-daemon-reload']],
    subscribe =>
    [
      File["${service_name}.service"],
      File["${airflow::home_folder}/airflow.cfg"]
    ]
  }
}
