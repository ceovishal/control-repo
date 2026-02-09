class profile::sqlserver_test {

  # Install default SQL Server instance
  sqlserver_instance { 'MSSQLSERVER':
    ensure                => present,
    source                => 'D:/',           # SQL Server ISO mounted on agent
    features              => ['SQL'],
    sql_sysadmin_accounts => ['Administrator'],
  }

  # Create a test database
  sqlserver::database { 'testdb':
    ensure   => present,
    instance => 'MSSQLSERVER',
    require  => Sqlserver_instance['MSSQLSERVER'],
  }

  # Create SQL login
  sqlserver::login { 'testlogin':
    instance => 'MSSQLSERVER',
    password => 'Pupp3t@123',
    require  => Sqlserver::Database['testdb'],
  }

  # Create DB user
  sqlserver::user { 'testdb-user-testlogin':
    user     => 'testlogin',
    database => 'testdb',
    require  => Sqlserver::Login['testlogin'],
  }
}
