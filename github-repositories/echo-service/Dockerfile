# Start from the official Go 1.17 image
FROM docker.io/golang:1.17

# Set the current working directory inside the container
WORKDIR /app

# Copy the Go modules manifest
COPY go.mod .

# Download the Go modules
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the binary executable
RUN go build -o app .

# Expose the application port
EXPOSE 8080

# Start the application
CMD ["./app"]
