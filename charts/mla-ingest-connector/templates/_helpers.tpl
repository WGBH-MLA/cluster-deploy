{{/*
Return the base name of the chart.
*/}}
{{- define "mla-ingest-connector.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end }}

{{/*
Return the full name, prefixed with the release name if needed.
*/}}
{{- define "mla-ingest-connector.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "mla-ingest-connector.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}
