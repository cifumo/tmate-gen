FROM ubuntu:22.04

# Mencegah prompt interaktif
ARG DEBIAN_FRONTEND=noninteractive

# 1. Update & Install dependencies dasar + SUDO
# 2. Setup Node.js v20
# 3. Install tools lainnya
RUN apt-get update && \
    apt-get install -y curl ca-certificates gnupg sudo && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y \
    nodejs \
    tmate \
    openssh-client \
    wget \
    unzip \
    neofetch \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# (Opsional) Secara eksplisit menetapkan user ke root
# Ini berguna jika base image pernah mengubah user sebelumnya
USER root

COPY package.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]
