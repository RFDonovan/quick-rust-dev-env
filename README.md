# Rust Container Development Environment 
Quick way to create a container development environment for Rust.

It should work with both *Docker* and *Podman*.

**Make** is used to simplify docker/podman commands.

## How to use
You will need to clone this repository first. 
Then:

1. Change the `PROJECT_NAME` variable within `Makefile`
2. `Make start` to create the container and run everything
3. `Make create` to create your project
4. `Make run` to build and run
5. `Make [add|remove] <crates>` to add or remove crate to your project
6. Customize the `Makefile` to your taste

Good luck!! ;)

