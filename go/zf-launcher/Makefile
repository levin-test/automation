.PHONY: build install clean test

BINARY_NAME=zf-launcher
INSTALL_PATH=$(HOME)/.local/bin

build:
	go build -ldflags="-s -w" -o $(BINARY_NAME) ./cmd/zf-launcher

install: build
	mkdir -p $(INSTALL_PATH)
	cp $(BINARY_NAME) $(INSTALL_PATH)/
	chmod +x $(INSTALL_PATH)/$(BINARY_NAME)

clean:
	rm -f $(BINARY_NAME)
	go clean

test:
	go test -v ./...

run: build
	./$(BINARY_NAME)
