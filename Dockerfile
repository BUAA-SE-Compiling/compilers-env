FROM debian:buster

#RUN sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list

RUN apt update && apt install wget curl gnupg2 -y

# nodejs repo
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# dotnet core sdk repo
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
    wget -q https://packages.microsoft.com/config/debian/10/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list && \
    chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg && \
    chown root:root /etc/apt/sources.list.d/microsoft-prod.list

RUN apt update && apt install apt-transport-https -y

RUN apt update && apt install build-essential \
    g++ gcc python3.7 openjdk-11-jdk cmake make \
    automake openssh-server git dotnet-sdk-3.0 nodejs -y
    
# install maven
RUN apt update && apt install maven -y

# golang
RUN goRelSha256='692d17071736f74be04a72a06dab9cac1cd759377bd85316e52b2227604c004c' ; \
    url="https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz"; \
    wget -O go.tgz "$url"; \
    echo "${goRelSha256} *go.tgz" | sha256sum -c -; \
    tar -C /usr/local -xzf go.tgz; \
    rm go.tgz; \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# Rust nightly
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

ENV PATH="/root/.cargo/bin:${PATH}"

CMD ["/bin/bash"]
