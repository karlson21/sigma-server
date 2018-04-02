FROM golang:1.9

# Copy the local package files to the container's workspace.
ADD ./app/ /go/src/tmp/sigma-server

# Build the command inside the container.
RUN go install tmp/sigma-server

# Run the command by default when the container starts.
ENTRYPOINT ["/go/bin/sigma-server", "-port", "8080"]

EXPOSE 8080
