server_build:
	mkdir build || true
	dart compile exe bin/server.dart --output build/spaghettiserver