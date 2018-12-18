from rust
run apt-get update && apt-get -y install libfuse-dev
workdir /src
env USER root
run cargo init
copy Cargo.toml Cargo.lock ./
run cargo build --release
run cargo build
run rm src/*.rs
copy . .
run cargo build --release

from ubuntu
run apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get -y install \
  fuse \
  && apt-get clean
copy --from=0 \
  /src/target/release/fuseqemu \
  /opt/fuseqemu/
env PATH="/opt/fuseqemu:${PATH}"
