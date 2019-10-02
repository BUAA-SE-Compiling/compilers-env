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

CMD ["/bin/bash"]
