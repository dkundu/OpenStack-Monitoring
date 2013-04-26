######################################################################
# Usage :
#   Because each server needs monit, so put the following in site.pp
#   and inside the node definition::
#
#   class { 'monit::monit':
#           server_types => $server_types,
#  		      monit_account,
#			      monit_passwd,
#			      data_volumes => ['XXX', 'YYY', 'ZZZ'],
#   )
#
#
######################################################################



class monit::monit($server_types=['',],
  		$monit_account,
			$monit_passwd,
			$monit_interval = 120,
      $data_volumes=['sdb1','sdc1','sdd1','sde1','sdf1','sdg1','sdh1','sdi1','sdj1','sdk1','sdl1','sdm1','sdn1','sdo1','sdp1','sdq1','sdr1','sds1','sdt1','sdu1','sdv1','sdw1']
){
	package { 'monit':
        ensure => present,
        before => Package['monitplugins'],
    }
	package { 'monitplugins':
        ensure => present,
        before => File['/opt/monit/etc/'],
	}
	file { '/opt/monit':
        notify => Service['monit'], 
        ensure => directory,
        mode => 0644,
        before => File["/opt/monit/etc/"],
	}
	file { '/opt/monit/etc/':
        notify => Service['monit'], 
        ensure => directory,
        mode => 0644,
	}
	file { 'monitrc':
        notify => Service['monit'], 
        path => "/opt/monit/etc/monitrc",
        ensure => file,
        content => template("monit/monitrc.erb"),
	}
	file { '/opt/monit/etc/conf.d': 
        ensure => directory,
        mode => 0644,
	}
    file { '/etc/logrotate.d/monit':
        ensure => 'present',
        source => 'puppet:///modules/monit/monit_logrotate',
        owner => 'root',
        group => 'root',
        mode => 644,
        require => [Package['monit']],
    }
	
	monit::rcfile { $server_types: }
	
	service { 'monit':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }
}
