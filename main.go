package main

import (
	"fmt"
	"log"
	"net/http"
	"github.com/gorilla/mux"
)

func GetTask(writter http.ResponseWriter, request *http.Request) {
	fmt.Fprintln(writter, "Not yet implemented")
}

func CreateTask(writter http.ResponseWriter, request *http.Request) {
	fmt.Fprintln(writter, "Not yet implemented")	
}

func DeleteTask(writter http.ResponseWriter, request *http.Request) {
	fmt.Fprintln(writter, "Not yet implemented")
}


type Task struct {
	Id 		bson.ObjectId `bson:"_id" json:"id"`
	Name	string        `bson:"name" json:"name"`
	Content string        `bson:"content" json:"content"`
}


// our main function
func main() {
	router := mux.NewRouter()
	router.HandleFunc("/to-do/api/{id}", GetTask).Methods("GET")
	router.HandleFunc("/to-do/api/", 	 GetTasks).Methods("GET")
	router.HandleFunc("/to-do/api/", 	 CreateTask).Methods("POST")
	router.HandleFunc("/to-do/api/", 	 DeleteTask).Methods("DELETE")

	log.Fatal(http.ListenAndServe(":3000", router))
}


// https://www.codementor.io/codehakase/building-a-restful-api-with-golang-a6yivzqdo
// https://hackernoon.com/build-restful-api-in-go-and-mongodb-5e7f2ec4be94