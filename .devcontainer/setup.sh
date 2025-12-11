#!/bin/bash
set -e

echo "Setting up xv6 RISC-V Development Environment..."

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install basic dependencies
echo "Installing dependencies..."
sudo apt-get install -y \
    git \
    build-essential \
    gdb-multiarch \
    qemu-system-misc \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    autoconf \
    automake \
    autotools-dev \
    curl \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev \
    gawk \
    bison \
    flex \
    texinfo \
    gperf \
    libtool \
    patchutils \
    bc \
    zlib1g-dev \
    libexpat-dev \
    ninja-build

# Check QEMU version
echo "Verifying QEMU installation..."
qemu-system-riscv64 --version

# Set up RISC-V toolchain
echo "Setting up RISC-V GNU toolchain..."
if [ ! -d "/opt/riscv" ]; then
    sudo mkdir -p /opt/riscv
    cd /tmp
    
    # Clone and build RISC-V GNU toolchain
    git clone --depth=1 https://github.com/riscv/riscv-gnu-toolchain
    cd riscv-gnu-toolchain
    
    ./configure --prefix=/opt/riscv --enable-multilib
    sudo make -j$(nproc)
    
    # Add to PATH
    echo 'export PATH=/opt/riscv/bin:$PATH' >> ~/.bashrc
    echo 'export PATH=/opt/riscv/bin:$PATH' >> ~/.zshrc
    
    # Clean up
    cd ..
    rm -rf riscv-gnu-toolchain
else
    echo "RISC-V toolchain already installed"
fi

# Add PATH for current session
export PATH=/opt/riscv/bin:$PATH

# Verify installation
echo "Verifying toolchain installation..."
if command -v riscv64-unknown-elf-gcc &> /dev/null; then
    echo "RISC-V GCC installed: $(riscv64-unknown-elf-gcc --version | head -n1)"
else
    echo "Using system RISC-V GCC: $(riscv64-linux-gnu-gcc --version | head -n1)"
fi

# Test build
echo "Testing xv6 build..."
cd "$GITHUB_WORKSPACE" || cd /workspaces/*/
make clean || true

echo ""
echo "Setup complete! You can now build and run xv6:"
echo "   make qemu"
echo ""
echo "To exit QEMU, press: Ctrl-A then X"
echo ""
