resource "aws_cognito_user_pool" "funcionarios_lanchonete_user_pool" {
  name              = var.user_pool_name
  mfa_configuration = var.mfa_configuration

  schema {
    name                = "name"
    attribute_data_type = "String"
    required            = true
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
  }

  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
  }
}

resource "aws_cognito_user_pool_client" "lanchonete_user_pool_client" {
  name            = "lanchonete-client-funcionarios"
  user_pool_id    = aws_cognito_user_pool.funcionarios_lanchonete_user_pool.id
  generate_secret = false

explicit_auth_flows = [
  "ALLOW_ADMIN_USER_PASSWORD_AUTH"
   ]
}

resource "aws_cognito_user" "funcionario_balcao" {
  user_pool_id = aws_cognito_user_pool.funcionarios_lanchonete_user_pool.id
  username     = "00000000000"

  attributes = {
    name  = "Funcionario balcao"
    email = "balcao@gmail.com"
  }
}