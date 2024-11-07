# Use the official Go image as the base
FROM golang:1.20-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy only go.mod (no go.sum needed if no dependencies)
COPY go.mod ./

# Copy the entire application code
COPY . .

RUN apk add --no-cache bash

# Build the Go application with verbose output
RUN go build -v -o ascii-art-web .

# Start a new stage with a minimal Alpine image
FROM alpine:latest
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
COPY --from=builder /app/images /app/images   

# Expose the port for the web server
EXPOSE 8080

# Run the application
ENTRYPOINT ["./ascii-art-web"]
