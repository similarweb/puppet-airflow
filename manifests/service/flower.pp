# == Class: airflow::service::flower
# == Description: Creates a service for airflow-flower
#
class airflow::service::flower inherits airflow {
  ensure_resource(airflow::resource::service, 'airflow-flower')
  ensure_resource(python::pip,'flower')
}