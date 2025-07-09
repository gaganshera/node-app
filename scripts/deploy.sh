#!/bin/bash

# Exit on any error
set -e

echo "Updating package index..."
sudo apt-get update -y

echo "Installing prerequisites for Node.js..."
sudo apt-get install -y curl software-properties-common

echo "Installing Node.js (LTS version)..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Verifying Node.js and npm installation..."
node -v
npm -v

echo "Installing Git..."
sudo apt-get install -y git

echo "Verifying Git installation..."
git --version

echo "Installation complete!"

git clone https://github.com/gaganshera/node-app.git
cd node-app
npm install
