# Kali Linux latest
FROM kalilinux/kali-rolling

WORKDIR /usr/src/app

# Make sure user cloned caldera recursively.
ADD ./plugins/sandcat/payloads/sandcat.go-linux /opt/sandcat.go-linux

# Update
RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y dist-upgrade && apt -y autoremove && apt clean

# Install general utilities
RUN DEBIAN_FRONTEND=noninteractive apt -y install wordlists dnsutils mongodb-clients python3 python3-pip golang vim git procps

# Install web utilities
RUN DEBIAN_FRONTEND=noninteractive apt -y install curl dirb wget wfuzz gobuster nikto 

# Install network utilities
RUN DEBIAN_FRONTEND=noninteractive apt -y install avahi-daemon avahi-utils iputils-ping nmap net-tools

# Install jwt-linux
RUN wget -q -O /opt/jwt-linux.tar.gz https://github.com/mike-engel/jwt-cli/releases/download/6.0.0/jwt-linux.tar.gz
RUN tar -xvf /opt/jwt-linux.tar.gz -C /opt

ENTRYPOINT ["/opt/sandcat.go-linux"]