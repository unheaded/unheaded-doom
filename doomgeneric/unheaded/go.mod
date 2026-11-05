module github.com/unheaded/doomgeneric

go 1.24.0

require (
	github.com/BurntSushi/toml v1.6.0
	github.com/gorilla/websocket v1.5.3
	golang.org/x/sys v0.40.0
)

// auth dependency — remove this replace once unheaded publishes as a Go module
require unheaded v0.0.0

replace unheaded => ../../unheaded
