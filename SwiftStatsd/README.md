Manual steps to enable SwiftStatsD:
====================================

Edit the *conf files under /etc/swift dir on each swift node:


[add the following lines under /etc/swift/account-server.conf, object-server.conf, container-server.conf and proxy-server.conf file]




log_statsd_host = <%= storage_local_net_ip %>

log_statsd_port = 8125

log_statsd_default_sample_rate = 1

log_statsd_metric_prefix = <%= hostname %>



