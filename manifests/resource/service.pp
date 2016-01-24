# define: airflow::resource::service
# == Description: Creates a systemd service definition 
#
define airflow::resource::service ( $service_name = $name ) {
  file { "${airflow::systemd_service_folder}/${service_name}.service":
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/${service_name}.service.erb"),
    require => [ Python::Pip["$airflow::package_name"], File["$airflow::log_folder"] ]
  } ->
  service { "${service_name}":
    ensure => $airflow::service_ensure,
    enable => $airflow::service_enable,
  }	
}
