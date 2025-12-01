#!/bin/bash

echo "🔧 Setting up xv6 CTF environment..."

# Install dependencies
apt-get update
apt-get install -y \
    build-essential \
    gdb-multiarch \
    qemu-system-misc \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    vim \
    bc \
    xxd

# Build xv6
echo "🔨 Building xv6..."
cd xv6-riscv
make clean
make

echo "✅ Setup complete!"
echo ""
echo "To start xv6, run:"
echo "  cd xv6-riscv && make qemu"
echo ""
echo "To exit xv6: Press Ctrl+A then X"