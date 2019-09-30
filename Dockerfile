FROM debian:buster

#RUN sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list

RUN apt update && apt install build-essential g++ gcc python3.7 openjdk-11-jdk cmake make automake openssh-server git -y

CMD ["/bin/bash"]
