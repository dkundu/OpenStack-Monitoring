###########################################################################
# How to use it:
#
# This should be on all swift servers.
# Add the following into each node:
#
#   $graphite_server = 'IP_ADDRESS'
#   $graphite_port = '2003'
#   class {'statsdpy' :
#		graphite_server => $graphite_server,
#		graphite_port => $graphite_port,
#   }
#
###########################################################################

class statsdpy( $graphite_server,
				$graphite_port,
)
{
	package { 'statsdpy':
      		ensure => present,
      		before => File['/etc/statsdpy'],
    	}	
	file { '/etc/statsdpy':
		ensure => directory,
		recurse => true,
		mode => 0644,
		source => "puppet:///modules/statsdpy/conf",	
	}
	file {'/etc/statsdpy/statsd.conf':
		ensure => present,
		mode => 0644,
		content => template('statsdpy/statsd.conf.erb'),
		before => Service['statsdpy'],
	}
	file { '/var/log/statsdpy':
		ensure => directory,
                mode => 0644,
		before => Service['statsdpy'],
	}
	service { 'statsdpy':
      		ensure     => running,
      		enable     => true,
      		hasrestart => true,
      		hasstatus  => true,
    }
}

