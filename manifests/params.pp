# == Class: bareos::params
#
class bareos::params {
  $file_mode = '0660'
  $file_dir_mode = '0755'
  $file_owner = 'bareos'
  $file_group = 'bareos'
  $config_dir = '/etc/bareos'
  $config_dir_webui = '/etc/bareos-webui'

  $repo_release = 'latest'

  # supported release for each version
  $repo_avail_hash = {
    'Debian' => {
      '6' => [ '15.2', ],
      '7' => [ '15.2', '16.2', '17.2', 'latest', ],
      '8' => [ '15.2', '16.2', '17.2', 'latest', ],
      '9' => [ '17.2', 'latest', ],
    },
    'Ubuntu' => {
      '12.04' => [ '15.2', '16.2', '17.2', 'latest', ],
      '14.04' => [ '15.2', '16.2', '17.2', 'latest', ],
      '16.04' => [ '15.2', '16.2', '17.2', 'latest', ],
    },
    'Fedora' => {
      '21' => [ '15.2', ],
      '22' => [ '15.2', ],
      '23' => [ '16.2', ],
      '24' => [ '16.2', ],
      '25' => [ '17.2', ],
      '26' => [ '17.2', ],
    },
    'CentOS' => {
      '5' => [ '15.2', '16.2', ],
      '6' => [ '15.2', '16.2', '17.2', 'latest', ],
      '7' => [ '15.2', '16.2', '17.2', 'latest', ],
    },
    'RedHat'   => {
      '5' => [ '15.2', '16.2', ],
      '6' => [ '15.2', '16.2', '17.2', 'latest', ],
      '7' => [ '15.2', '16.2', '17.2', 'latest', ],
    },
  }
  $repo_manage_hash = undef

  # base
  $manage_repo = true
  $manage_user = true

  # defaults for the different services and base/common package
  $manage_package = true
  $manage_service = true
  $package_ensure = present
  $service_ensure = running
  $service_enable = true

  # base/common package
  if $::osfamily == 'Gentoo' {
    $package_name = 'bareos'
    $console_package_name = []
    $monitor_package_name = []
    $director_package_name = []
    $client_package_name = []
    $storage_package_name = []
    $webui_package_name = []
  } else {
    $package_name = 'bareos-common'

    # package specific
    # bconsole
    $console_package_name = 'bareos-bconsole'
  
    # monitor
    $monitor_package_name = 'bareos-traymonitor'
  
    # director
    $director_package_name = [
      'bareos-director',
      'bareos-director-python-plugin',
      'bareos-database-common',
      'bareos-database-mysql',
      'bareos-database-postgresql',
      'bareos-database-sqlite3',
      'bareos-database-tools',
    ]
  
    # filedaemon/client
    $client_package_name = ['bareos-filedaemon', 'bareos-filedaemon-python-plugin']
  
    # storage
    $storage_package_name = ['bareos-storage', 'bareos-storage-python-plugin', 'bareos-tools']
  
    # webui
    $webui_package_name = 'bareos-webui'
  }
  
  $director_service_name = 'bareos-dir'
  $client_service_name = 'bareos-fd'
  $storage_service_name = 'bareos-sd'
  $webui_service_name = 'apache2'
}
