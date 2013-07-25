class data(
  $devices = params_lookup('devices'),
) inherits data::params {
     class { 'data::fs': }
  -> Class['data']
}
