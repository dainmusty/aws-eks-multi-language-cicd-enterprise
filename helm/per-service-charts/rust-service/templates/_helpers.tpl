{{/*
############################################################
EXPAND THE CHART NAME
############################################################
*/}}

{{- define "rust-service.name" -}}

{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
CREATE FULL APPLICATION NAME
############################################################
*/}}

{{- define "rust-service.fullname" -}}

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

{{- define "rust-service.chart" -}}

{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
COMMON LABELS
#
# Applied to all Kubernetes resources
############################################################
*/}}

{{- define "rust-service.labels" -}}

helm.sh/chart: {{ include "rust-service.chart" . }}

{{ include "rust-service.selectorLabels" . }}

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

{{- define "rust-service.selectorLabels" -}}

app.kubernetes.io/name: {{ include "rust-service.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

{{- end -}}



{{/*
############################################################
SERVICE ACCOUNT NAME
############################################################
*/}}

{{- define "rust-service.serviceAccountName" -}}

{{- if .Values.serviceAccount.create -}}

{{- default (include "rust-service.fullname" .) .Values.serviceAccount.name -}}

{{- else -}}

{{- default "default" .Values.serviceAccount.name -}}

{{- end -}}

{{- end -}}