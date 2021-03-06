{{/*
Creates defaultBaseUrl based on environment
*/}}
{{- define "vigobas-samtykke.defaultBaseUrl" -}}
{{- if .Values.environment eq "pwf" }}
{{- printf "https://play-with-fint.felleskomponent.no" }}
{{- else }}
{{- printf "https://%s.felleskomponent.no" .Values.environment }}
{{- end }}
{{- end }}

{{/*
Creates One Password Vault path based on environment
*/}}
{{- define "vigobas-samtykke.onePasswordVaultPath" -}}
{{- printf "vaults/aks-%s-vault/items" .Values.environment }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "vigobas-samtykke.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vigobas-samtykke.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "vigobas-samtykke.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vigobas-samtykke.labels" -}}
helm.sh/chart: {{ include "vigobas-samtykke.chart" . }}
{{ include "vigobas-samtykke.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vigobas-samtykke.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vigobas-samtykke.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vigobas-samtykke.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vigobas-samtykke.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
