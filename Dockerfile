# Use the official httpd image as the base
FROM httpd:latest

# Copy all files from the current directory to the /usr/local/apache2/htdocs/ directory in the container
COPY . /usr/local/apache2/htdocs/

# Expose port for 80
EXPOSE 8082
