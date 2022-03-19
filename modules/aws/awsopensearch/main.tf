# Creating the Opensearch domain

resource "aws_iam_service_linked_role" "es" {
    aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain
  elasticsearch_version = var.elasticsearch_version
 
  cluster_config {
    instance_type = var.instance_type
    zone_awareness_enabled = true
    instance_count = var.instance_count
    dedicated_master_count = var.master_instance_count
    dedicated_master_enabled = true
    dedicated_master_type = var.master_instance_type
    zone_awareness_config {
      availability_zone_count = var.availability_zone_count
    }
  }
  
  snapshot_options {
    automated_snapshot_start_hour = 23
  }
  vpc_options {
    subnet_ids = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }
  encrypt_at_rest {
    enabled = true
  }
  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }
  node_to_node_encryption {
    enabled = true
  }
  ebs_options {
    ebs_enabled = var.ebs_volume_size > 0 ? true : false
    volume_size = var.ebs_volume_size
    volume_type = var.volume_type
  }
  
  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.awsopensearch.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }

  tags = {
    Domain = var.tag_domain
  }
  depends_on = [aws_iam_service_linked_role.es]
}
 
  #Creating the AWS opensearch domain policy
 
resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = aws_elasticsearch_domain.es.domain_name
  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "${aws_elasticsearch_domain.es.arn}/*"
        }
    ]
}
POLICIES
}


# create cloudwatch resource
resource "aws_cloudwatch_log_group" "awsopensearch" {
  name = var.log_group_name
}

resource "aws_cloudwatch_log_resource_policy" "awsopensearch" {
  policy_name = var.log_group_policy

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG
}
