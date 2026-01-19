
class profile::agent::legacy_facts {
  # Ensure puppet.conf contains the legacy facts setting
  ini_setting { 'enable_legacy_facts':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'include_legacy_facts',
    value   => 'true',
  }
}
