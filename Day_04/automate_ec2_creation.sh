#!/bin/bash
# Strict mode: Exit on error, undefinedi vars or pipeline failures

# 1. Improved check/install logic
check_awscli() {
	if  command -v aws &> /dev/null; then
		echo "✅ AWS CLI is already installed."
		return 0
	else
		echo "AWS CLI is missing."
		return 1
	fi
}

# Function to install AWS CLI
install_awscli() {
	echo "📥 Downloading AWS CLI v2 installer..."
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

	# Ensure unzip is installed (required for the AWS installer)
        sudo apt-get update && sudo apt-get install -y unzip &> /dev/null

        unzip -qo awscliv2.zip
        echo "🚀 Running AWS CLI installation..."
        sudo ./aws/install --update

        # Clean up installation files
        rm -rf awscliv2.zip ./aws

        # Refresh PATH immediately so the current script can see the new 'aws' command
        export PATH=$PATH:/usr/local/bin

        # Final verification
        aws --version
}
wait_for_instance() {
    local instance_id="$1"
    echo "⏳ Waiting for instance $instance_id to reach 'running' state..."

    while true; do
        # Get status safely
        state=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].State.Name' --output text 2>/dev/null || echo "pending")

        if [[ "$state" == "running" ]]; then
            echo "✨ Instance $instance_id is now LIVE."
            break
        fi
        sleep 10
    done
}
create_ec2_instance() {
    local ami_id="$1"
    local instance_type="$2"
    local key_name="$3"
    local subnet_id="$4"
    local sg_ids="$5"
    local name="$6"

    # Validation: Ensure no empty critical variables
    if [[ -z "$ami_id" || -z "$key_name" || -z "$subnet_id" ]]; then
        echo "❌ Error: Missing required AWS parameters (AMI, Key, or Subnet)."
        exit 1
    fi

    echo "🛰️ Launching EC2 Instance..."
    # Note the corrected Tag Specification syntax
    instance_id=$(aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --key-name "$key_name" \
        --subnet-id "$subnet_id" \
        --security-group-ids "$sg_ids" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=\"$name\"}]" \
        --query 'Instances[0].InstanceId' \
        --output text)

    echo "✅ Instance Created: $instance_id"
    wait_for_instance "$instance_id"
}
main() {
    # Logic: If check_awscli fails (returns 1), run install_awscli
    check_awscli || install_awscli

    echo "🚀 Proceeding with EC2 instance creation..."

    # Parameters for the EC2 instance (Replace these with your actual IDs)
    AMI_ID="ami-09e320d375d7b8d3e"        # Required: Check AWS Console for latest AMI
    INSTANCE_TYPE="t3.micro"
    KEY_NAME="Shell_Scripting_For_Devops_Key"                 # Required: Must exist in your AWS Region
    SUBNET_ID="subnet-00230158e22e41099"          # Required: Find in VPC Dashboard
    SECURITY_GROUP_IDS="sg-0f0f2993f71ad3c93"     # Required: Find in EC2 Dashboard
    INSTANCE_NAME="Automate-EC2-Creation"

    # Call function to create instance
    create_ec2_instance "$AMI_ID" "$INSTANCE_TYPE" "$KEY_NAME" "$SUBNET_ID" "$SECURITY_GROUP_IDS" "$INSTANCE_NAME"

    echo "✅ EC2 instance automation completed."
}

# Execute main function with all script arguments
main "$@"


