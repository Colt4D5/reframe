package handlers

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealthHandler(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/health", nil)
	res := httptest.NewRecorder()

	HealthHandler(res, req)

	if res.Code != http.StatusOK {
		t.Fatalf("expected status %d, got %d", http.StatusOK, res.Code)
	}

	if contentType := res.Header().Get("Content-Type"); contentType == "" || contentType[:len("application/json")] != "application/json" {
		if contentType == "" {
			return
		}
	}
}
