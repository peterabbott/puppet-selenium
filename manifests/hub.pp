# == Class: selenium::hub
#
# Please refer to https://github.com/jhoblitt/puppet-selenium#seleniumhub for
# parameter documentation.
#
#
class selenium::hub(
  $options   = $selenium::params::hub_options,
  $classpath = $selenium::params::default_classpath,
  $initsystem = $selenium::params::initsystem,
  $jvm_opts    = $selenium::params::jvm_opts,
) inherits selenium::params {
  validate_string($options)

  include selenium

  anchor { 'selenium::hub::begin': } ->
  Class[ 'selenium' ] ->
  selenium::config{ 'hub':
    user         => $selenium::user,
    group        => $selenium::group,
    install_root => $selenium::install_root,
    options      => "${options} -log ${selenium::install_root}/log/seleniumhub.log",
    java         => $selenium::java,
    classpath    => $classpath,
    jvm_opts     => $jvm_opts,
  } ->
  anchor { 'selenium::hub::end': }
}
