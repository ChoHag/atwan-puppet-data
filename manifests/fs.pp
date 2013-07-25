class data::fs {
  if $data::devices != 'UNDEFINED' {
    create_resources('data::fs::device', $data::devices)
  }
}

define data::fs::device (
  $path = 'UNDEFINED',
  $size = 'UNDEFINED',
) {
  Exec {
    environment => [
      "path=$path",
      "size=$size",
    ],
  }

  file { $path:
    ensure => directory,
  }

  -> exec { "fail-unless-mounted-$name":
    command => "test \"$(stat -c%m \"\$path\")\" = \"\${path%/}\"";
  }

  -> exec { "fail-unless-big-enough-$name":
    command => "test \"$(df -Pm \"\$path\" | awk 'END{print\$2}')\" -ge \"\$size\"";
  }
}
