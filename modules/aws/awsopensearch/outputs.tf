output "opensearch_endpoint" {
    description = "Opensearch endpoint"
    value = aws_elasticsearch_domain.es.endpoint
} 
output "dashboard_endpoint" {
    description = "Opensearch dashboard endpoint"
    value = aws_elasticsearch_domain.es.kibana_endpoint
}