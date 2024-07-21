# # FROM debian:latest

# # # Install necessary packages
# # RUN apt-get update && \
# #     apt-get install -y cowsay fortune netcat-openbsd && \
# #     rm -rf /var/lib/apt/lists/*

# # # Copy the shell script into the image
# # COPY wisecow.sh /app/wisecow.sh

# # # Make the shell script executable
# # RUN chmod +x /app/wisecow.sh

# # # Set the working directory
# # WORKDIR /app

# # # Expose the port the application will run on
# # EXPOSE 4499

# # # Run the application
# # CMD ["./wisecow.sh"]

# FROM ubuntu:latest

# # Install necessary packages
# RUN apt-get update && \
#     apt-get install -y fortune cowsay netcat-openbsd

# # Copy and set permissions for the script
# COPY wisecow.sh /wisecow.sh
# RUN chmod +x /wisecow.sh

# # Set the script as the default command
# CMD ["/wisecow.sh"]
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cowsay \
    fortune \
    netcat-openbsd \
    dos2unix

# Copy the script
COPY wisecow.sh /usr/local/bin/wisecow.sh

# Ensure the script has Unix line endings and is executable
RUN dos2unix /usr/local/bin/wisecow.sh && chmod +x /usr/local/bin/wisecow.sh

# Define the entrypoint
ENTRYPOINT ["/usr/bin/env", "bash", "/usr/local/bin/wisecow.sh"]


