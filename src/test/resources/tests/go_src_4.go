// The code snippet is obtained from "https://gobyexample.com/xml"

// Incorrect version

package main

import (
	"encoding/xml"
	"fmt"
)

hype Plant struct { // go
	XMLName xml.Name `xml:"plant"`
	Id      int      `xml:"id,attr"`
	Name    string   `xml:"name"`
	Origin  []string `xml:"origin"`
}