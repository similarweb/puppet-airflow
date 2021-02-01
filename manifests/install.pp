# == Class: airflow::install
# == Description: Install airflow python package using pip.
#
class airflow::install inherits airflow {
  if $airflow::manage_install {
    # Create virtualenv for airflow
    ensure_resource(
      python::pyvenv,
      $airflow::virtualenv,
      {
        ensure       => present,
        version      => $airflow::python,
        systempkgs   => true,
        venv_dir     => "/home/${airflow::user}/venv/${airflow::virtualenv}",
        owner        => $airflow::user,
        group        => $airflow::group,
      }
    )

    if $airflow::requirements {
      python::requirements { $airflow::requirements:
        manage_requirements => false,
      }
    } else {
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
}
