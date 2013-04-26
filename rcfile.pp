define monit::rcfile {
  file { $title:
 		path => "/opt/monit/etc/conf.d/$title.rc",
 		ensure => file,
		content => template("monit/$title.rc.erb"),
		before => Service['monit'],
		require => File['/opt/monit/etc/conf.d'],
		notify => Service['monit'],
	}
}
