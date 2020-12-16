# we ignore changes to the value on all of this because I don't actually want to manage the values from Terraform.
# I just want Terraform to create these to make it easier to get started.
# Instead, Gitlab will push values to these parameters when it pushes up new containers.
# We actually store the secrets in AKeyless and then Gitlab pulls them from there and pushes them to the parameter store.
# Theoretically, you could just manage them directly in AWS, but for us these values come
# from a few different people/teams.  AKeyless works well for this despite the extra hop because with
# AKeyless it is very easy to share access to a specific secret with specific people, so I
# can easily have the relevant people set *just* their specific secret, rather than having
# to manage access to the SSM parameter store directly or have them send me the secret in an insecure channel.
# It would be even easier if we could just have the ECS task pull them straight from AKeyless but ECS
# really only plays nicely with the SSM parameter store, so this is the best solution for us at the moment.

resource "aws_ssm_parameter" "checkmarx_password" {
  name = "/cxflow/${var.environment}/checkmarx/password"
  description = "The password that CxFlow will use to login to Checkmarx"
  type = "SecureString"
  value = "Filler"
  tags = local.all_tags

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "checkmarx_username" {
  name = "/cxflow/${var.environment}/checkmarx/username"
  description = "The username that CxFlow will use to login to Checkmarx"
  type = "SecureString"
  value = "Filler"
  tags = local.all_tags

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "checkmarx_token" {
  name = "/cxflow/${var.environment}/checkmarx/token"
  description = "This token is associated with the default endpoint for driving a scan/results but that is not also associated with a webhook event payload (which is a separate token)"
  type = "SecureString"
  value = "Filler"
  tags = local.all_tags

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "checkmarx_url" {
  name = "/cxflow/${var.environment}/checkmarx/url"
  description = "The URL of the checkmarx server"
  type = "String"
  value = "Filler"
  tags = local.all_tags

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "gitlab_token" {
  name = "/cxflow/${var.environment}/gitlab/token"
  description = "The token used by CxFlow to log back into Gitlab and push out changes"
  type = "SecureString"
  value = "Filler"
  tags = local.all_tags

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "gitlab_webhook_token" {
  name = "/cxflow/${var.environment}/gitlab/webhook-token"
  description = "Preshared secret between GitLab and CxFlow - used when registering the webhook for auth"
  type = "SecureString"
  value = "Filler"
  tags = var.tags

  lifecycle {
    ignore_changes = [value]
  }
}
