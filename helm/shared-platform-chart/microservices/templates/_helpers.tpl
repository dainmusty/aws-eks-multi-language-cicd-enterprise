{{/*
############################################################
EXPAND THE CHART NAME
############################################################
*/}}

{{- define "microservice.name" -}}

{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
CREATE FULL APPLICATION NAME
############################################################
*/}}

{{- define "microservice.fullname" -}}

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

{{- define "microservice.chart" -}}

{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
COMMON LABELS
#
# Applied to all Kubernetes resources
############################################################
*/}}

{{- define "microservice.labels" -}}

helm.sh/chart: {{ include "microservice.chart" . }}

{{ include "microservice.selectorLabels" . }}

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

{{- define "microservice.selectorLabels" -}}

app.kubernetes.io/name: {{ include "microservice.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

{{- end -}}



{{/*
############################################################
SERVICE ACCOUNT NAME
############################################################
*/}}

{{- define "microservice.serviceAccountName" -}}

{{- if .Values.serviceAccount.create -}}

{{- default (include "microservice.fullname" .) .Values.serviceAccount.name -}}

{{- else -}}

{{- default "default" .Values.serviceAccount.name -}}

{{- end -}}

{{- end -}}