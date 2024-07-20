# Use an official Debian runtime as a parent image
FROM debian:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y cowsay fortune netcat && \
    rm -rf /var/lib/apt/lists/*

# Copy the script into the container
COPY script.sh /app/script.sh

# Make the script executable
RUN chmod +x /app/script.sh

# Set the working directory
WORKDIR /app

# Expose the port on which the server will run
EXPOSE 4499

# Run the script
CMD ["./script.sh"]
