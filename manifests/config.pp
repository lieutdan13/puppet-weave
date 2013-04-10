class weave::config (
	$config = {}
) {
	file { "/etc/weave.conf":
		content => template("weave/weave.conf.erb"),
	}
}
