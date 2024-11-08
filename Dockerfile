# Use the official Go image as the base
FROM golang:1.23-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy only go.mod (no go.sum needed if no dependencies)
COPY go.mod ./

RUN go mod download

# Copy the entire application code
COPY . .

RUN apk add --no-cache bash

# Build the Go application with verbose output
RUN go build -v -o ascii-art-web .

# Start a new stage with a minimal Alpine image
FROM alpine:latest

# Create a non-root user and group, set permissions for /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Metadata (optional)
LABEL maintainer="Stamatis Manousis, Avgoustinos Andris"
LABEL version="v1.0"
LABEL description="Ascii Art Web Server"
LABEL source="https://platform.zone01.gr/git/smanousi/ascii-art-web-dockerize"

# Copy the built application and required files
COPY --from=builder /app/ascii-art-web .
COPY --from=builder /app/templates /app/templates
COPY --from=builder /app/static /app/static     
COPY --from=builder /app/banners /app/banners  
COPY --from=builder /app/static/images /app/static/images  

# Change ownership of /app directory to appuser
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the port for the web server
EXPOSE 8080

# Run the application
CMD ["./ascii-art-web"]
