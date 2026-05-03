#!/bin/bash

app_dir="/var/www/html"
service="nginx"

# Function: Check prerequisites
check_prerequisites() {
	if ! command -v nginx &>/dev/null; then
		echo "❌ Error: Nginx not installed. Install with: sudo apt install nginx"
		exit 1
	fi
}

# Function: Backup and Deploy app
deploy_app() {
	if [ ! -d "$app_dir" ]; then
		echo"❌ Error: App directory $app_dir not found"
		exit 1
	fi

	# Backup existing index.html if exists
	if [ -f "$app_dir/index.html" ]; then
		echo "📦 Backing up existing index.html..."
		sudo cp "$app_dir/index.html" "$app_dir/index.html.bak"
	fi
	
	echo "<h1> Welcome to Rajesh's App</h1><p>Server IP: $(hostname -I | awk '{print $1}')</p>" | sudo tee "$app_dir/index.html"
	> /dev/null	

	if [ $? -ne 0 ]; then
		echo "❌ Error: Failed to write index.html. Try running with sudo."
		exit 1
	fi
}

# Function: Start service
start_service() {
	echo "🚀 Starting Nginx..."
	if sudo systemctl restart "$service"; then
		echo "✅ $service started successfully"
	else
		echo "❌ Error: Failed to start $service"
		exit 1
	fi
}

# Function: Verify and Show URL
verify_deployment() {
	# Get the local IP address
	IP_ADDR=$(hostname -I | awk '{print $1}')

	if curl -s http://localhost | grep -q "Rajesh"; then
		echo "-------------------------------------------"
    		echo "✅ Deployment successful!"
    		echo "🌐 Access your app at: http://$IP_ADDR"
    		echo "-------------------------------------------"
  	else
    		echo "❌ Error: Deployment failed (could not verify content)"
    		exit 1
  	fi
}

# Main workflow
check_prerequisites
deploy_app
start_service
verify_deployment


