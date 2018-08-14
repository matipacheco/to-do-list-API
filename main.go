package main

import (
	"encoding/json"
	"log"
	"net/http"
	"github.com/gorilla/mux"
)

func GetTask(writter http.ResponseWriter, r *http.Request) {
	
}

func CreateTask(writter http.ResponseWriter, r *http.Request) {
	
}

func DeleteTask(writter http.ResponseWriter, r *http.Request) {
	
}

// our main function
func main() {
	router := mux.NewRouter()
	router.HandleFunc("/to-do/api/{id}", GetTask).Methods("GET")
	router.HandleFunc("/to-do/api/{id}", CreateTask).Methods("POST")
	router.HandleFunc("/to-do/api/{id}", DeleteTask).Methods("DELETE")

	log.Fatal(http.ListenAndServe(":8000", router))
}


// https://www.codementor.io/codehakase/building-a-restful-api-with-golang-a6yivzqdo
// https://hackernoon.com/build-restful-api-in-go-and-mongodb-5e7f2ec4be94