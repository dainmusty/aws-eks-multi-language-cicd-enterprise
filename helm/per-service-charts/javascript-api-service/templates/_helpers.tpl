{{/*
############################################################
EXPAND THE CHART NAME
############################################################
*/}}

{{- define "javascript-api.name" -}}

{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
CREATE FULL APPLICATION NAME
############################################################
*/}}

{{- define "javascript-api.fullname" -}}

{{- if .Values.fullnameOverride -}}

{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}

{{- else -}}

{{- $name := default .Chart.Name .Values.nameOverride -}}

{{- if contains $name .Release.Name -}}

{{- .Release.Name | trunc 63 | trimSuffix "-" -}}

{{- else -}}

{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}

{{- end -}}

{{- end -}}

{{- end -}}



{{/*
############################################################
CHART NAME + VERSION
############################################################
*/}}

{{- define "javascript-api.chart" -}}

{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
COMMON LABELS
#
# Applied to all Kubernetes resources
############################################################
*/}}

{{- define "javascript-api.labels" -}}

helm.sh/chart: {{ include "javascript-api.chart" . }}

{{ include "javascript-api.selectorLabels" . }}

app.kubernetes.io/managed-by: {{ .Release.Service }}

app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}

{{- end -}}



{{/*
############################################################
SELECTOR LABELS
#
# Used for:
# - pod selectors
# - services
# - deployments
############################################################
*/}}

{{- define "javascript-api.selectorLabels" -}}

app.kubernetes.io/name: {{ include "javascript-api.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

{{- end -}}



{{/*
############################################################
SERVICE ACCOUNT NAME
############################################################
*/}}

{{- define "javascript-api.serviceAccountName" -}}

{{- if .Values.serviceAccount.create -}}

{{- default (include "javascript-api.fullname" .) .Values.serviceAccount.name -}}

{{- else -}}

{{- default "default" .Values.serviceAccount.name -}}

{{- end -}}

{{- end -}}