{{/*
Expand the name of the chart.
*/}}
{{- define "element_call.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "element_call.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Create a default LiveKit Management Service name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "element_call.livekit_mgmt_name" -}}
{{- printf "%s-%s" .Release.Name "livekit-mgmt-svc" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "element_call.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "element_call.labels" -}}
helm.sh/chart: {{ include "element_call.chart" . }}
{{ include "element_call.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "element_call.livekit_mgmt.labels" -}}
helm.sh/chart: {{ include "element_call.chart" . }}
{{ include "element_call.livekit_mgmt.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "element_call.selectorLabels" -}}
app.kubernetes.io/name: {{ include "element_call.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector Labels for livekit mgmt
*/}}
{{- define "element_call.livekit_mgmt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "element_call.livekit_mgmt_name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end}}



{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "element_call.redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Set redis host
*/}}
{{- define "element_call.redis.host" -}}
{{- if .Values.redis.enabled -}}
{{- printf "%s-%s" (include "element_call.redis.fullname" .) "master" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{ required "A valid externalRedis.host is required" .Values.externalRedis.host }}
{{- end -}}
{{- end -}}

{{/*
Set redis secret
*/}}
{{- define "element_call.redis.secret" -}}
{{- if .Values.redis.enabled -}}
{{- template "element_call.redis.fullname" . -}}
{{- else -}}
{{- template "element_call.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Set redis port
*/}}
{{- define "element_call.redis.port" -}}
{{- if .Values.redis.enabled -}}
{{- .Values.redis.master.service.port | default 6379 }}
{{- else -}}
{{ required "A valid externalRedis.port is required" .Values.externalRedis.port }}
{{- end -}}
{{- end -}}

{{/*
Set redis password
*/}}
{{- define "element_call.redis.password" -}}
{{- if (and .Values.redis.enabled .Values.redis.password) -}}
{{ .Values.redis.password }}
{{- else if (and .Values.redis.enabled .Values.redis.auth.password) -}}
{{ .Values.redis.auth.password }}
{{- else if .Values.externalRedis.password -}}
{{ .Values.externalRedis.password }}
{{- end -}}
{{- end -}}

{{/*
Set redis database id
*/}}
{{- define "element_call.redis.dbid" -}}
{{- if .Values.redis.dbid -}}
{{ .Values.redis.dbid }}
{{- else if .Values.externalRedis.dbid -}}
{{ .Values.externalRedis.dbid }}
{{- end -}}
{{- end -}}
