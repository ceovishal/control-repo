## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##

# The default node definition matches any node lacking a more specific node
# definition. If there are no other node definitions in this file, classes
# and resources declared in the default node definition will be included in
# every node's catalog.
#
# Note that node definitions in this file are merged with node data from the
# Puppet Enterprise console and External Node Classifiers (ENC's).
#
# For more on node definitions, see: https://puppet.com/docs/puppet/latest/lang_node_definitions.html
#node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
#}
node 'inert-clot.delivery.puppetlabs.net' {

  # Ensure the puppetlabs-sqlserver module is installed on the master
  # and pluginsync is enabled on the agent.

  sqlserver_instance { 'MSSQLSERVER':
    ensure                 => present,
    # Path to the root of the SQL Server installation media OR a share
    # that contains Setup.exe and required payloads.
    # Example:
    # source => 'C:\\Installers\\SQLServer2019',
    source                 => 'C:\\Installers\\SQLServer', 

    # Use correct feature IDs. For SQL Database Engine use 'SQLENGINE'.
    features               => ['SQLENGINE'],

    # Mixed mode authentication
    security_mode          => 'SQL',
    sa_pwd                 => 'p@ssw0rd!!',

    # Local or domain accounts that should be sysadmin
    sql_sysadmin_accounts  => ['myuser'],

    # Install switches must be strings. Paths can be single-quoted.
    install_switches       => {
      'TCPENABLED'           => '1',
      'SQLBACKUPDIR'         => 'C:\\MSSQLSERVER\\backupdir',
      'SQLTEMPDBDIR'         => 'C:\\MSSQLSERVER\\tempdbdir',
      'INSTALLSQLDATADIR'    => 'C:\\MSSQLSERVER\\datadir',
      'INSTANCEDIR'          => 'C:\\Program Files\\Microsoft SQL Server',
      'INSTALLSHAREDDIR'     => 'C:\\Program Files\\Microsoft SQL Server',
      'INSTALLSHAREDWOWDIR'  => 'C:\\Program Files (x86)\\Microsoft SQL Server',
    },
  }

}

}

