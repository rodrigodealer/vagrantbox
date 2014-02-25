# Puppet module: varnish

This is a Puppet module for varnish based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Javier Bertoli / Netmanagers

Official site: http://www.netmanagers.com.ar

Official git repository: http://github.com/netmanagers/puppet-varnish

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install varnish with default settings

        class { 'varnish': }

* Install a specific version of varnish package

        class { 'varnish':
          version => '1.0.1',
        }

* Disable varnish service.

        class { 'varnish':
          disable => true
        }

* Remove varnish package

        class { 'varnish':
          absent => true
        }

* Enable auditing without without making changes on existing varnish configuration *files*

        class { 'varnish':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'varnish':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'varnish':
          source => [ "puppet:///modules/example42/varnish/varnish.conf-${hostname}" , "puppet:///modules/example42/varnish/varnish.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'varnish':
          source_dir       => 'puppet:///modules/example42/varnish/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'varnish':
          template => 'example42/varnish/varnish.conf.erb',
        }

* Automatically include a custom subclass

        class { 'varnish':
          my_class => 'example42::my_varnish',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'varnish':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'varnish':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'varnish':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'varnish':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/netmanagers/puppet-varnish.png?branch=master" alt="Build Status" />}[https://travis-ci.org/netmanagers/puppet-varnish]

