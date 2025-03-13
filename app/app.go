package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

func appHandler(w http.ResponseWriter, r *http.Request) {

	fmt.Println(time.Now(), "Hello from my fresh new server")

	w.WriteHeader(http.StatusOK)
	fmt.Fprint(w, "Hello from my fresh new server")
}

func healthHandler(w http.ResponseWriter, r *http.Request) {

	fmt.Println(time.Now(), "New health check")

	w.WriteHeader(http.StatusOK)
	fmt.Fprint(w, "Healthy :)")
}


func main() {
	http.HandleFunc("/", appHandler)
	http.HandleFunc("/_health", healthHandler)

	log.Println("Started, serving on port 8080")
	err := http.ListenAndServe(":8080", nil)

	if err != nil {
		log.Fatal(err.Error())
	}
}