FROM ubuntu:jammy

# Install required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git zsh openssh-server sudo curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create user kzl and set up password
RUN useradd -m -U -G sudo,adm kzl && \
    echo "kzl:password" | chpasswd

# Generate SSH host keys
RUN ssh-keygen -A

# Enable and start SSH service
RUN mkdir /run/sshd

# Allow password authentication (optional, ensure to configure securely)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Switch to user kzl
USER kzl
WORKDIR /home/kzl

# Set up projects directory and clone repository
RUN git clone --depth 1 https://github.com/lz3450/LFS.git
RUN mkdir -p /home/kzl/Projects

# Set up zsh configuration
WORKDIR /home/kzl/LFS/config/zsh
RUN ./oh-my-zsh.sh

# Link git configuration
RUN ln -rsf /home/kzl/LFS/config/git/.gitconfig /home/kzl/

# Expose SSH port
EXPOSE 22

# Set entrypoint to run sshd
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
