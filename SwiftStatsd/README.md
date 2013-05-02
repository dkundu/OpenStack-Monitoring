Manual steps to enable SwiftStatsD:
====================================

Edit the *conf files under /etc/swift dir on each swift node:


[add the following lines under /etc/swift/account-server.conf file]


logconfig=/etc/swift/logging.conf

loghandler=account

log_custom_handlers  = swift.common.ocp_swift_logger.log

log_statsd_host = <%= storage_local_net_ip %>

log_statsd_port = 8125

log_statsd_default_sample_rate = 1

log_statsd_metric_prefix = <%= hostname %>

[add the following lines under /etc/swift/object-server.conf file]

logconfig=/etc/swift/logging.conf
loghandler=object
log_custom_handlers  = swift.common.ocp_swift_logger.log
log_statsd_host = <%= storage_local_net_ip %>
log_statsd_port = 8125
log_statsd_default_sample_rate = 1
log_statsd_metric_prefix = <%= hostname %>

[add the following lines under /etc/swift/container-server.conf file]

logconfig=/etc/swift/logging.conf
loghandler=container
log_custom_handlers  = swift.common.ocp_swift_logger.log
log_statsd_host = <%= storage_local_net_ip %>
log_statsd_port = 8125
log_statsd_default_sample_rate = 1
log_statsd_metric_prefix = <%= hostname %>


[ add the following lines under /etc/swift/proxy-server.conf file]


logconfig=/etc/swift/logging.conf
loghandler=proxy
log_custom_handlers  = swift.common.ocp_swift_logger.log
log_statsd_host = <%= swift_local_net_ip %>
log_statsd_port = 8125
log_statsd_default_sample_rate = 1
log_statsd_metric_prefix = <%= hostname %>

