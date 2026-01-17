# Naming Standard/Convention

# <Organization>-<Department>-<Domain/Business Unit>-<Environment>-<Region>-<Tier>-<Resource Type>
# 1. Organization = netflix
# 2. Department = it
# 3. Domain/Business Unit = ai
# 4. Environment = dev
# 5. Region = us-east-2
# 6. Tier = frontend
# 7. Resource Type = ec2

locals {
    # Naming Standard/Convention
    name = "${var.org}-${var.dep}-${var.bu}-${var.env}-${var.region}-${var.tier}-rtype"

    # Common Tags
    common_tags = {
        Environment = var.env
        BusinessUnit = var.bu
        Tier = var.tier
        Team = "devop"
        Project_Name = "streaming-ai"
        Managed_by = "Terraform"
        Owner = "support@akumosolutions.io"
}
}

# Tagging Standard/Convention
# Common tags (Cost Allocation Tags)