package main

import (
    "fmt"
    "log"
    "net/http"
)

func main() {
    // Create a new HTTP server
    server := http.NewServeMux()

    // Define a handler function for the root endpoint "/"
    server.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        // Get the query parameter "message"
        message := r.URL.Query().Get("message")

        // Write the message back to the response
        if message != "" {
            fmt.Fprintf(w, "Echo: %s", message)
        } else {
            fmt.Fprint(w, "No message received.")
        }
    })

    // Start the server and listen on port 8080
    log.Println("Starting server on port 8080...")
    err := http.ListenAndServe(":8080", server)
    if err != nil {
        log.Fatal(err)
    }
}
