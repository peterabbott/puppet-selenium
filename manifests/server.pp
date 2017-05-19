# == Class: selenium::server
#
# Please refer to https://github.com/jhoblitt/puppet-selenium#seleniumserver
# for parameter documentation.
#
#
class selenium::server(
  $display     = $selenium::params::display,
  $options     = $selenium::params::server_options,
  $classpath   = $selenium::params::default_classpath,
  $initsystem  = $selenium::params::initsystem,
  $jvm_opts    = $selenium::params::jvm_opts,
) inherits selenium::params {
  validate_string($display)
  validate_string($options)

  include selenium

  $merged_options = "${options} -log ${selenium::install_root}/log/seleniumserver.log"

  anchor { 'selenium::server::begin': } ->
  Class[ 'selenium' ] ->
  selenium::config{ 'server':
    display      => $display,
    user         => $selenium::user,
    group        => $selenium::group,
    install_root => $selenium::install_root,
    options      => $merged_options,
    java         => $selenium::java,
    classpath    => $classpath,
    initsystem   => $initsystem,
    jvm_opts     => $jvm_opts,
    driver_opts  => $driver_opts,
  } ->
  anchor { 'selenium::server::end': }
}
