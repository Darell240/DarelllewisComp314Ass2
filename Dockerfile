# Use lightweight Nginx image
FROM nginx:alpine

# Copy all files to Nginx's web directory
COPY . /usr/share/nginx/html

# Set Artgallery.html as the default page
RUN mv /usr/share/nginx/html/Artgallery.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
