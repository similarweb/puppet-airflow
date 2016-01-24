# == Class: airflow::service::scheduler
# == Description: Creates a service for airflow-scheduler
#
class airflow::service::scheduler inherits airflow {
  ensure_resource(airflow::resource::service, 'airflow-scheduler')
}

