class weave::install {
	package { 'gzip': ensure => 'present' }
	package { 'tar': ensure => 'present' }
	package { 'unzip': ensure => 'present' }
	package { 'wget': ensure => 'present' }

	exec {
		"java8_wget":
			command => "/usr/bin/wget http://www.java.net/download/JavaFXarm/jdk-8-ea-b36e-linux-arm-hflt-29_nov_2012.tar.gz -O /tmp/jdk-8.tar.gz",
			creates => "/tmp/jdk-8.tar.gz",
			require => [ Package["wget"] ];

		"java8_unzip":
			cwd     => "/opt",
			command => "/bin/tar -vxzf /tmp/jdk-8.tar.gz -C /opt",
			creates => "/opt/jdk1.8.0/bin/java",
			require => [ Package ["tar"], Package["gzip"], Package["unzip"], Exec["java8_wget"] ];
	}

	class{ git:
		svn     => false,
		gui     => false,
	}

	git::repo{ "weave":
		path    => '/opt/weave',
		source  => 'git://github.com/ambled/weave-test-java.git'
	}
}
