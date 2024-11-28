# Enable AWS plugin to validate AWS-specific resources
plugin "aws" {
  enabled = true
  region  = "us-east-1"
}

# Enforce naming conventions for resources
rule "terraform_module_pinned_source" {
  enabled = true
}

rule "variable_name_convention" {
  enabled = true
  arguments = {
    pattern = "^[a-z][a-z0-9_]*$" # Enforces lowercase, underscores, and numbers
  }
}

rule "resource_s3_bucket_invalid_name" {
  enabled = true
}

# Example custom rules for resource name spelling or patterns
rule "custom_name_check" {
  enabled = true
  arguments = {
    pattern = "^[a-zA-Z0-9_-]+$" # Only allows valid resource name characters
  }
}
