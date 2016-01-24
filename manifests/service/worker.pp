# == Class: airflow::service::worker
# == Description: Creates a service for airflow-worker
#
class airflow::service::worker inherits airflow {
  ensure_resource(airflow::resource::service, 'airflow-worker')
}