resource "aws_sqs_queue" "main" {
  name = replace(local.name, "rtype", "sqs")
    tags = merge(
      local.common_tags,
      {
        Name = replace(local.name, "rtype", "sqs")
      }
    )
}

resource "aws_db_instance" "main" {
    identifier                = replace(local.name, "rtype", "db")
    allocated_storage         = 10
    db_name                   = "mydb"  # Database Name inside the instance
    engine                    = "mysql"
    instance_class            = "db.t3.micro"
    engine_version            = "8.0"
    username                  = "admin"
    password                  = random_password.password.result
    parameter_group_name      = "default.mysql8.0"

    # skip_final_snapshot       = true
    # final_snapshot_identifier = null

    skip_final_snapshot       = var.env == "prod" ? true : false # true = no snapshot, false = snapshot will be created  
    final_snapshot_identifier = var.env == "prod" ? null : "${replace(lower(local.name), "rtype", "snapshot")}-${formatdate("YYYY-MM-DD-HH-mm-ss", timestamp())}"

     # ^ true - no argument needed, false = needs an argument
     tags = merge(
      local.common_tags,
      {
        Name = replace(local.name, "rtype", "db")
      }
    )
}
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


# Equality Operator:
# 1 = "1"
# >> false

# sun == sun>> true

# Conditional Expression:
# Syntax: condition ? first_value : second_value

# Example:
# "apple" == "apple" ? "great" : "bad"
# >> "great"

# "grape" != "tomato" ? "5" : "10"
# >> "5"

# var.env != var.tier ? var.team : var.bu
# >> var.team

# 8 == 5 ? "no" : 8 == 6 ? "no" : 8 == 7 ? "no" : "yes"
# >> "yes"