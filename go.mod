module unheaded-doom

go 1.26.0

toolchain go1.27.3

require (
	github.com/BurntSushi/toml v1.6.0
	github.com/gorilla/websocket v1.5.3
	github.com/unheaded/doomgeneric v0.0.0
	golang.org/x/sys v0.49.0
	unheaded v0.0.0
)

require (
	github.com/lib/pq v1.12.3 // indirect
	github.com/mattn/go-colorable v0.1.16 // indirect
	github.com/mattn/go-isatty v0.0.24 // indirect
	github.com/rs/zerolog v1.35.1 // indirect
	golang.org/x/net v0.62.0 // indirect
	golang.org/x/text v0.43.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20261019180522-ce908d29299b // indirect
	google.golang.org/grpc v1.84.0 // indirect
	google.golang.org/protobuf v1.36.12 // indirect
)

replace (
	github.com/unheaded/doomgeneric => ./doomgeneric/unheaded
	unheaded => ../../unheaded
)
