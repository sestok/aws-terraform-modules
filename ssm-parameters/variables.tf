variable "name" {
    type = string
    description = "Display name of the SSM Parameter Store parameter name."

    validation {
        condition = (length(var.name) >= 1 && length(var.name) <= 2048 && can(regex("^/(test|uat|prod)/", var.name)))
        error_message = "SSM parameter names must be between 1 (min) and 2048 (max) characters long and follow the naming convention (test|uat|prod)/."
    }
}

variable "description" {
    type = string
    description = "Description of the SSM Parameter Store parameter as viewed in the AWS console."
}

variable "value" {
    type = string
    description = "Value of the SSM Parameter Store parameter. If parameter type is SecureString, the value should be retrieved from a GitHub secret."
}

variable "key_id" {
    type = string
    description = "Customer managed KMS key id or arn used to encrypt the SSM Parameter Store parameter if type is SecureString."
    default = "alias/aws/ssm"
}

variable "tier" {
    type = string
    description = "Tier of the SSM Parameter Store parameter. Valid types are Standard, Advanced and Intelligent-Tiering."
    default = "Standard"

    validation {
        condition = (contains(["Standard", "Advanced", "Intelligent-Tiering"], var.tier))
        error_message = "Unsupported SSM parameter tier. Valid tiers: [Standard, Advanced, Intelligent-Tiering]."
    }
}

variable "tags" {
    type = map(string)
    description = "Key-value map of resource tags to be associated with the SSM Parameter Store parameter."

    validation {
      condition = (
                    contains(keys(var.tags), "owner") &&
                    contains(keys(var.tags), "env")
      )
      error_message = "Incomplete or invalid set of tags specified for the SSM Parameter Store parameter. Tags for every resource are required to have the following keys:\n\t- owner\n\t- env."
    }
}
