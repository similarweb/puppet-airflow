# == Class: airflow::install
# == Description: Install airflow python package using pip.
#
class airflow::install inherits airflow {
  # Create virtualenv for airflow
  ensure_resource(
    python::virtualenv,
    $airflow::virtualenv,
    {
      ensure       => present,
      version      => $airflow::python,
      systempkgs   => true,
      venv_dir     => "/home/${airflow::user}/venv/${airflow::virtualenv}",
      requirements => $airflow::requirements,
      owner        => $airflow::user,
      group        => $airflow::group,
    }
  )

  if ! $requirements {
    # Use pip
    ensure_resource(
      python::pip,
      $airflow::package_name,
      {
        pkgname    => $airflow::package_name,
        virtualenv => "/home/${airflow::user}/${airflow::virtualenv}",
        ensure     => $airflow::version,
        owner      => $airflow::user
      }
    )
  }
}
