package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
)

func main() {
	fmt.Println("Starting server on port 8080...")
	router := gin.Default()
	router.SetTrustedProxies(nil)

	router.GET("/api/test", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "This is a test and stuff...",
			"success": true,
		})
	})

	router.Run(":8080")
}