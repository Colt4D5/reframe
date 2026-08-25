package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"

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

	router.GET("/api/v1/news", func(c *gin.Context) {
		baseURL := "https://newsdata.io/api/1/latest"
		params := url.Values{}
		params.Set("apikey", "pub_8be20b1d78664adab0c39dffa0f1c334")
		params.Set("country", "us,gb,ca")
		params.Set("language", "en")
		params.Set("category", "politics,technology,entertainment,science,world")
		params.Set("timezone", "america/los_angeles")
		params.Set("prioritydomain", "medium")

		newsURL := baseURL + "?" + params.Encode()

		resp, err := http.Get(newsURL)
		if err != nil {
			c.JSON(http.StatusBadGateway, gin.H{
				"error":   "Failed to fetch news from external API",
				"details": err.Error(),
			})
			return
		}
		defer resp.Body.Close()

		body, err := io.ReadAll(resp.Body)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error":   "Failed to read news response",
				"details": err.Error(),
			})
			return
		}

		if resp.StatusCode != http.StatusOK {
			c.JSON(resp.StatusCode, gin.H{
				"error":   "News API request failed",
				"details": string(body),
			})
			return
		}

		var payload map[string]any
		if err := json.Unmarshal(body, &payload); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error":   "Failed to decode news payload",
				"details": err.Error(),
			})
			return
		}

		c.JSON(http.StatusOK, payload)
	})

	router.Run(":8080")
}
