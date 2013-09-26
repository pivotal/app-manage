# == Class: redis
#
# Full description of class redis here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { redis:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#


# Defaults are taken from redis.conf as distributed with 2.6
# The values specified are not checked for sanity.
class redis (
  $ensure = running,
  $version = 'latest',
  $listen_address = '127.0.0.1',
  $listen_port = '6379',
  $timeout = '0',
  $tcp_keepalive = '0',
  $redis_loglevel = 'notice', #this has redis_ prefixed to avoid a conflict with puppet's loglevel
  $logfile = 'stdout',
  $syslog_enabled = 'no',
  $syslog_ident = 'redis',
  $syslog_facility = 'local0',
  $databases = '16',
  $save = [ '900 1', '300 10', '60 10000'],    #Array for each save line
  $stop_writes_on_bgsave_error = 'yes',
  $rdbcompression = 'yes',
  $rdbchecksum = 'yes',
  $dbfilename = 'dump.rdb',
  $dir = "./",
  $slaveof = '',
  $masterauth = '',
  $slave_serve_stale_data = 'yes',
  $slave_read_only = 'yes',
  $repl_ping_slave_period = '10',
  $repl_timeout = '60',
  $repl_disable_tcp_nodelay = 'no',
  $slave_priority = '100',
  $requirepass = '',
  $rename_command = '',  #Array of each rename command line
  $maxclients = '10000',
  $maxmemory = '',
  $maxmemory_policy = 'volatile-lru',
  $maxmemory_samples = '3',
  $appendonly = 'no',
  $appendfilename = 'appendonly.aof',
  $appendfsync = 'everysec',
  $no_appendfsync_on_rewrite = 'no',
  $auto_aof_rewrite_percentage = '100',
  $auto_aof_rewrite_min_size = '64mb',
  $lua_time_limit = '5000',
  $slowlog_log_slower_than = '10000',
  $slowlog_max_len = '128',
  $hash_max_ziplist_entries = '512',
  $hash_max_ziplist_value = '64',
  $list_max_ziplist_entries = '512',
  $list_max_ziplist_value = '64',
  $zset_max_ziplist_entries = '128',
  $zset_max_ziplist_value = '64',
  $activerehashing = 'yes',
  $client_output_buffer_limit = ['normal 0 0 0', 'slave 256mb 64mb 60', 'pubsub 32mb 8mb 60' ],
  $hz = '10',
  $aof_rewrite_incremental_fsync = 'yes'
) {

  class { 'redis::install':
    version => $version
  } ->

  class { 'redis::config':
    listen_address => $listen_address,
    listen_port => $listen_port,
    timeout => $timeout,
    tcp_keepalive => $tcp_keepalive,
    loglevel => $loglevel,
    logfile => $logfile,
    syslog_enabled => $syslog_enabled,
    syslog_ident => $syslog_ident,
    syslog_facility => $syslog_facility,
    databases => $databases,
    save => $save,
    stop_writes_on_bgsave_error => $stop_writes_on_bgsave_error,
    rdbcompression => $rdbcompression,
    rdbchecksum => $rdbchecksum,
    dbfilename =>$dbfilename,
    dir => $dir,
    slaveof => $slaveof,
    masterauth => $masterauth,
    slave_serve_stale_data => $slave_serve_stale_data,
    slave_read_only => $slave_read_only,
    repl_ping_slave_period => $repl_ping_slave_period,
    repl_timeout => $repl_timeout,
    repl_disable_tcp_nodelay => $repl_disable_tcp_nodelay,
    slave_priority => $slave_priority,
    requirepass => $requirepass,
    rename_command => $rename_command,
    maxclients => $maxclients,
    maxmemory => $maxmemory,
    maxmemory_policy => $maxmemory_policy,
    maxmemory_samples => $maxmemory_samples,
    appendonly => $appendonly,
    appendfilename => $appendfilename,
    appendfsync => $appendfsync,
    no_appendfsync_on_rewrite => $no_appendfsync_on_rewrite,
    auto_aof_rewrite_percentage => $auto_aof_rewrite_percentage,
    auto_aof_rewrite_min_size => $auto_aof_rewrite_min_size,
    lua_time_limit => $lua_time_limit,
    slowlog_log_slower_than => $slowlog_log_slower_than,
    slowlog_max_len => $slowlog_max_len,
    hash_max_ziplist_entries => $hash_max_ziplist_entries,
    hash_max_ziplist_value => $hash_max_ziplist_value,
    list_max_ziplist_entries => $list_max_ziplist_entries,
    list_max_ziplist_value => $list_max_ziplist_value,
    zset_max_ziplist_entries => $zset_max_ziplist_entries,
    zset_max_ziplist_value => $zset_max_ziplist_value,
    activerehashing => $activerehashing,
    client_output_buffer_limit => $client_output_buffer_limit,
    hz => $hz,
    aof_rewrite_incremental_fsync => $aof_rewrite_incremental_fsync,
  } ->
  class { 'redis::service':
    ensure => $ensure
  }
}
