
```markdown
# Deploying Application on AWS VPC using Terraform Provisioners

This project demonstrates deploying a simple Flask application on AWS VPC using Terraform for infrastructure provisioning.

## Overview

The project sets up the following components:
- AWS VPC (Virtual Private Cloud)
- Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance

It then deploys a Flask application on the EC2 instance using Terraform provisioners.

## Prerequisites

Make sure you have the following tools installed on your local machine:
- [Terraform](https://www.terraform.io/)
- [AWS CLI](https://aws.amazon.com/cli/)

## Usage

1. Clone the repository:

    ```bash
    git clone <repository_url>
    cd <repository_directory>
    ```

2. Initialize Terraform:

    ```bash
    terraform init
    ```

3. Create the infrastructure:

    ```bash
    terraform apply
    ```

4. Follow the prompts to confirm the infrastructure changes.

5. Once the infrastructure is created, you can access the deployed application by connecting to the public IP of the EC2 instance.

## Project Structure

```
.
├── app.py                    # Flask application code
├── main.tf                   # Terraform main configuration file
├── terraform.tfstate         # Terraform state file (gitignored)
├── variables.tf              # Terraform variables
└── README.md                 # Project documentation
```

## Cleanup

To avoid incurring charges, don't forget to destroy the resources after testing:

```bash
terraform destroy
```

## Note

- Ensure that your AWS credentials are configured on your local machine using the AWS CLI.

- Customize the `app.py` file to include your application logic.

## License

This project is licensed under the [MIT License](LICENSE).
```

Feel free to modify the content according to your project specifics and include additional sections or details as needed.
