# == Class: airflow::service::webserver
# == Description: Creates a service for airflow-webserver
#
class airflow::service::webserver inherits airflow {
  ensure_resource(airflow::resource::service, 'airflow-webserver')
}
