FROM ubuntu

RUN apt-get update && apt-get install -y \
    ca-certificates \
    build-essential \
    cmake \
    locales \
    curl \
    python \
    nodejs \
    default-jdk

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN curl -s https://s3.amazonaws.com/mozilla-games/emscripten/packages/emscripten/nightly/linux/emscripten-latest.tar.gz -o emscripten-latest.tar.gz && \
    curl -s https://s3.amazonaws.com/mozilla-games/emscripten/packages/llvm/nightly/linux_64bit/emscripten-llvm-latest.tar.gz -o emscripten-llvm-latest.tar.gz

RUN mkdir emscripten && mkdir llvm && \
    tar -xzf emscripten-latest.tar.gz -C emscripten --strip-components=1 && \
    tar -xzf emscripten-llvm-latest.tar.gz -C llvm --strip-components=1 && \
    ln -s /emscripten/emcc /usr/local/bin && \
    emcc && \
    sed -i.bak "s/LLVM_ROOT =.*/LLVM_ROOT = '\/llvm\/'/" /root/.emscripten && \
    touch /root/.emscripten && \
    echo 'int main() {}' > tmp.c && \
    emcc tmp.c && emcc -s WASM=1 tmp.c && rm tmp.c

WORKDIR /src/
