# Airflow

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with airflow](#setup)
    * [Limitations - OS compatibility, etc.](#limitations)
    * [What airflow affects](#what-airflow-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with airflow](#beginning-with-airflow)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages [airflow][1] by [Airbnb][2].

## Module Description

The airflow module sets up and configures airflow.

This module has been tested against airflow versions: 1.9.0

## Setup

### Limitations
This module does not initialize the airflow database schema - you can do so by executing:
```
airflow initdb
```
More info [here][5].

The module has been tested on Ubuntu 15.10+


### The module manages the following

* Airflow package.
* Airflow configuration file.
* Airflow services.
* Airflow templates.

### Important Note
* This module does not install: MySQL, PostgreSQL, RabbitMQ or Redis - You have to use other modules for them. We use [puppetlabs/mysql][6], [puppetlabs/rabbitmq][7] and [garethr/erlang][8].

Please refer to airflow [installation][3] before using this module.

### Setup Requirements

airflow module depends on the following puppet modules:

* puppetlabs-stdlib >= 4.9.0
* stankevich-python >= 1.14.2
* camptocamp-systemd >= 1.0.0

### Beginning with airflow

Install this module via any of these approaches:

* [librarian-puppet][4]
* [git-submodule][5]
* `puppet module install similarweb-airflow`

## Usage

### Main class

#### Install airflow 1.9.0 with mysql support

```puppet
class { 'airflow':
          package_name => 'apache-airflow[mysql]',
          version      => '1.9.0',
          home_folder  => '/usr/local/airflow'
      }
```

#### Install airflow using a pip requirements file

Having a requirements file simplifies things, as all related python packages can be installed at once.

For example, to use Google's oauth you have to install `flask_oauthlib` into the same virtualenv as the rest of airflow.

The following code depends on puppet previously putting down the file at `/usr/local/share/airflow_reqs.txt`,
whether through a `file` command or some other way.

```puppet
class { 'airflow':
          python       => '3.4',
          requirements => '/usr/local/share/airflow_reqs.txt',
          home_folder  => '/usr/local/airflow'
      }
```

#### Install airflow, the work scheduler and the celery based worker

```puppet
class { 'airflow': } ->
class { 'airflow::service::scheduler:' }
class { 'airflow::service::worker:' }
```

## Hiera Support

* Example: Defining ldap authentication and mesos settings in hiera.

```yaml
airflow::ldap_settings:
  ldap_url: ldap:://<your.ldap.server>:<port>
  user_filter: objectClass=*
  user_name_attr: uid
  bind_user: cn=Manager,dc=example,dc=com
  bind_password: insecure
  basedn: dc=example,dc=com


airflow::mesos_settings:
  master: localhost:5050
  framework_name: Airflow
  task_cpu: 1
  task_memory: 256
  checkpoint: false
  failover_timeout: 604800
  authenticate: false
  default_principal: admin
  default_secret: admin

```
## Reference

### Classes

#### Public classes

* `airflow` - Installs and configures airflow.
* `airflow::service::worker` - Handles airflow's worker service.
* `airflow::service::scheduler` - Handles airflow's scheduler service.
* `airflow::service::webserver` - Handles airflow's webserver service.
* `airflow::service::flower` - Handles airflow's flower service.

#### Private classes
* `airflow::install` - Installs airflow python package.
* `airflow::config` - Configures airflow.


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Commit your changes.
4. Submit a Pull Request using Github


[1]: https://github.com/airbnb/airflow
[2]: https://www.airbnb.com
[3]: http://pythonhosted.org/airflow/installation.html
[4]: https://github.com/rodjek/librarian-puppet
[5]: https://github.com/airbnb/airflow/blob/master/docs/start.rst
[6]: https://github.com/puppetlabs/puppetlabs-mysql
[7]: https://github.com/puppetlabs/puppetlabs-rabbitmq
[8]: https://github.com/garethr/garethr-erlang
