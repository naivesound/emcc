# emcc

Emscripten + Binaryen in docker container

## Usage

```
# asm.js
docker run --rm -t -v $(pwd):/src naivesound/emcc emcc foo.c

# WebAssembly
docker run --rm -t -v $(pwd):/src naivesound/emcc emcc -s WASM=1 foo.c
```

## Build

```
docker build -t naivesound/emcc .
```
