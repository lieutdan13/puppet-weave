class weave::uninstall (
	$java   = true,
	$weave  = true,
	$path   = "/opt/weave",
	$config = true,
	$git    = false
) {

	if ( $git ) {
		require git::params

		if ! defined(Package[$git::params::package]) {
			package{$git::params::package: ensure => absent}
		}

		package{$git::params::svn_package: ensure => absent}
		package{$git::params::gui_package: ensure => absent}
	}

	if ( $java ) {
		file { "/tmp/jdk-8.tar.gz": ensure  => absent }
		file { "/opt/jdk1.8.0": ensure  => absent, force => true }
	}

	if ( $weave ) {
		file { $path: ensure => absent, force => true }
	}

	if ( $config ) {
		file { "/etc/weave.conf": ensure => absent }
	}

}
