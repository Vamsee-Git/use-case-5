# Use the official Node.js image for version 16
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the local package.json and package-lock.json into the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app will run on
EXPOSE 3000

# Run the application
CMD ["npm", "start"]
