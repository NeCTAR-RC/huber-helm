{{- define "huber-conf" }}
[DEFAULT]
debug={{ .Values.conf.debug }}

[notification]
exchange={{ .Values.conf.notification.exchange }}
topic={{ .Values.conf.notification.topic }}
pool={{ .Values.conf.notification.pool }}

[handlers]
{{- if .Values.conf.handlers.enabled }}
enabled={{ join "," .Values.conf.handlers.enabled }}
{{- end }}

[project_membership]
subject={{ .Values.conf.project_membership.subject }}
tenantmanager_role={{ .Values.conf.project_membership.tenantmanager_role }}
member_role={{ .Values.conf.project_membership.member_role }}

[oslo_messaging_rabbit]
ssl=True
rabbit_quorum_queue=true
rabbit_transient_quorum_queue=true
rabbit_stream_fanout=true
rabbit_qos_prefetch_count=1

[oslo_messaging_notifications]
driver = messagingv2

[service_auth]
auth_url={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}

{{- end }}
