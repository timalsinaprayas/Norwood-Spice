aws_region = "us-east-2"
environment = "production"
project_name = "norwoodspice"

frontend_cpu = 256
frontend_memory = 512
backend_cpu = 512
backend_memory = 1024

desired_count_frontend = 2
desired_count_backend = 1

# GitHub Configuration (replace with your actual repository)
github_repository = "your-username/Norwood-Spice"

# Leave empty to use latest images, or specify specific image URIs
frontend_image_uri = ""
backend_image_uri = ""

# Note: aws_account_id will be determined automatically
