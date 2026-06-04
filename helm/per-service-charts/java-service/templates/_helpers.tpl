{{/*
############################################################
EXPAND THE CHART NAME
############################################################
*/}}

{{- define "java-service.name" -}}

{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
CREATE FULL APPLICATION NAME
############################################################
*/}}

{{- define "java-service.fullname" -}}

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

{{- define "java-service.chart" -}}

{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}

{{- end -}}



{{/*
############################################################
COMMON LABELS
#
# Applied to all Kubernetes resources
############################################################
*/}}

{{- define "java-service.labels" -}}

helm.sh/chart: {{ include "java-service.chart" . }}

{{ include "java-service.selectorLabels" . }}

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

{{- define "java-service.selectorLabels" -}}

app.kubernetes.io/name: {{ include "java-service.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

{{- end -}}



{{/*
############################################################
SERVICE ACCOUNT NAME
############################################################
*/}}

{{- define "java-service.serviceAccountName" -}}

{{- if .Values.serviceAccount.create -}}

{{- default (include "java-service.fullname" .) .Values.serviceAccount.name -}}

{{- else -}}

{{- default "default" .Values.serviceAccount.name -}}

{{- end -}}

{{- end -}}