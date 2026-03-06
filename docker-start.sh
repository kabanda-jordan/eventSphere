#!/bin/bash
# EventSphere Docker Quick Start Script for Linux/Mac
# This script starts the EventSphere application using Docker Compose

echo "========================================"
echo "  EventSphere Docker Deployment"
echo "========================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed"
    echo "Please install Docker from: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "ERROR: Docker Compose is not installed"
    echo "Please install Docker Compose from: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "Docker is installed and ready!"
echo ""

# Check if .env file exists, if not create from example
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo ".env file created with default values"
    echo ""
fi

echo "Starting EventSphere containers..."
echo "This may take a few minutes on first run..."
echo ""

# Start Docker Compose
docker-compose up --build

# Cleanup message
echo ""
echo "========================================"
echo "  EventSphere Stopped"
echo "========================================"
echo ""
echo "To start again, run: ./docker-start.sh"
echo "To stop and remove containers: docker-compose down"
echo ""
