# Profile - NEC WSUS client
#
class profile::os::windows::wsus_client(
  #String $server_url          = 'http://win2016-wsus.vm:8530',
  String $server_url          = 'http://10.191.251.39:8530',
  #String $server_url          = 'http://10.192.81.37:8530',
  String $auto_update_option  = 'AutoNotify',
  Boolean $disable_dual_scan   = true,
) {
  class { 'wsus_client':
    server_url           => $server_url,  # WSUS Server
    enable_status_server => true,         # Send status to WSUS too
    auto_update_option   => 'AutoNotify', # automatically download updates and notify for install
    purge_values         => true,
  }

  $dual_scan = $disable_dual_scan? { true => '1', default => '0' }
  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\DisableDualScan':
    ensure => present,
    type   => 'dword',
    data   => $dual_scan,
  }
}

