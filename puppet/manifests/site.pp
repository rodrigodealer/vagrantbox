exec { "apt-update":
    command => "/usr/bin/apt-get update -y"
}

Exec["apt-update"] -> Package <| |>

class nginx {
  package { "nginx":
    ensure => present
  }
    service { "nginx":
        ensure  => "running",
        require => Package["nginx"]
    }

    file { "/var/www":
        ensure  => "link",
        target  => "/vagrant/web",
        require => Package["nginx"],
        notify  => Service["nginx"],
        force => true,
    }
}

class java { 
    package {"openjdk-6-jdk": 
        ensure  =>  present 
    } 
} 

class scala {
	package { "scala":
		ensure => present
	}
}

class jetty {
	package { "jetty":
		ensure => present
	}
}

class varnish {
	package { "varnish":
		ensure => present
	}
}

file { '/etc/varnish/default.vcl':
  ensure => file,
  mode   => 600,
  source => 'puppet:///modules/varnish/default_vcl.txt',
}

class mysql {
  package { "mysql-server":
    ensure => present
  }
  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }
  exec { "Set MySQL server root password":
        require => Package["mysql-server"],
        unless => "/usr/bin/mysqladmin -uroot -proot status",
        command => "/usr/bin/mysqladmin -uroot password root",
  }
}

class { 'rbenv': install_dir => '/opt/rbenv' }
rbenv::plugin { 'sstephenson/ruby-build': }
rbenv::build { '2.1.1': global => true }

include nginx
include mysql
include jetty
include scala
include java
include varnish