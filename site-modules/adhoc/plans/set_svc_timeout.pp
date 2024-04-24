class surfscan::profile::set_svc_timeout {

  # Check if ServicesPipeTimeout registry entry exists
  $registry_value_exists = reg_exists('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ServicesPipeTimeout')

  if $registry_value_exists {
    # Modify the existing ServicesPipeTimeout registry entry
    registry_value { 'ServicesPipeTimeout':
      key   => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control',
      value => 'ServicesPipeTimeout',
      type  => 'dword',
      data  => '60000',
    }
  } else {
    # Create the ServicesPipeTimeout registry entry
    registry_key { 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control':
      ensure => present,
    }
    registry_value { 'ServicesPipeTimeout':
      key   => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control',
      value => 'ServicesPipeTimeout',
      type  => 'dword',
      data  => '60000',
    }
  }
}
