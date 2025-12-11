# xv6 Operating System Vulnerability Labs

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/LamaanAliBukhsh/OS_vuln_labs-xv6-riscv-)

A hands-on learning environment for exploring operating system vulnerabilities using MIT's xv6 teaching operating system on RISC-V architecture.

## 🚀 Quick Start (Recommended)

### Option 1: GitHub Codespaces (Zero Setup! ✨)

**This is the easiest way to get started** - no installation required!

1. **Click the badge above** or [click here](https://codespaces.new/LamaanAliBukhsh/OS_vuln_labs-xv6-riscv-)
2. Wait 2-3 minutes for the environment to set up automatically
3. Once ready, open the terminal and run:
   ```bash
   make qemu
   ```
4. Start exploiting! 🎯

**To exit QEMU:** Press `Ctrl-A` then `X`

#### What Gets Installed Automatically:
- ✅ RISC-V GNU toolchain
- ✅ QEMU RISC-V emulator (v7.2+)
- ✅ All build dependencies
- ✅ VS Code extensions for C/C++ development

### Option 2: Local Setup (Advanced Users)

If you prefer to work locally, you'll need to install:

#### Prerequisites
- RISC-V GNU toolchain (`riscv64-unknown-elf-gcc`)
- QEMU for RISC-V (`qemu-system-riscv64`)
- Standard build tools (`gcc`, `make`, etc.)

#### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install git build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
```

#### macOS
```bash
brew tap riscv/riscv
brew install riscv-tools qemu
```

#### Build and Run
```bash
git clone https://github.com/LamaanAliBukhsh/OS_vuln_labs-xv6-riscv-.git
cd OS_vuln_labs-xv6-riscv-
make qemu
```

## 📚 Lab Structure

This repository contains vulnerable xv6 implementations designed for educational purposes:

### Available Labs

1. **Buffer Overflow Exploitation**
   - Understand stack-based vulnerabilities
   - Exploit buffer overflows in kernel space
   - Learn about stack canaries and protections

2. **Race Condition Vulnerabilities**
   - Explore TOCTOU (Time-of-Check-Time-of-Use) bugs
   - Understand concurrent access issues
   - Practice exploitation techniques

3. **Privilege Escalation**
   - Gain elevated privileges through vulnerabilities
   - Understand user/kernel boundaries
   - Learn about capability violations

*(More labs coming soon!)*

## 🛠️ Working with xv6

### Basic Commands

Build the kernel:
```bash
make
```

Run in QEMU:
```bash
make qemu
```

Run with debugging support:
```bash
make qemu-gdb
# In another terminal:
gdb-multiarch kernel/kernel
(gdb) target remote localhost:26000
```

Clean build artifacts:
```bash
make clean
```

### Inside xv6

Once xv6 boots, you'll see a shell prompt (`$ `). Try these commands:
```bash
ls           # List files
cat README   # Display file contents
grep x README # Search for 'x' in README
forktest     # Test process forking
usertests    # Run user-level tests
```

## 🎓 Learning Resources

### Understanding the Vulnerabilities

Before diving into exploitation, read the accompanying Medium article:
- [Link to your Medium article - Understanding OS Vulnerabilities with xv6]

### xv6 Documentation
- [xv6 Book (PDF)](https://pdos.csail.mit.edu/6.828/2023/xv6/book-riscv-rev3.pdf)
- [MIT 6.S081 Course](https://pdos.csail.mit.edu/6.828/2023/schedule.html)
- [xv6 Source Code Commentary](https://github.com/mit-pdos/xv6-riscv)

## 🔍 Exploring Vulnerabilities

### Example: Buffer Overflow Lab

1. **Read the vulnerability description** in the Medium article
2. **Examine the vulnerable code** in `kernel/` or `user/`
3. **Compile and run** the vulnerable program
4. **Craft your exploit** to trigger the vulnerability
5. **Verify the exploit** works as expected

### Example Session
```bash
# Start xv6
make qemu

# Inside xv6 shell
$ ls
$ forphan    # Run a vulnerable program
$ dorphan    # Trigger the vulnerability
```

## 📁 Repository Structure

```
OS_vuln_labs-xv6-riscv-/
├── .devcontainer/          # GitHub Codespaces configuration
│   ├── devcontainer.json
│   └── setup.sh
├── kernel/                 # xv6 kernel source code
│   ├── proc.c             # Process management
│   ├── syscall.c          # System call handling
│   ├── vm.c               # Virtual memory
│   └── ...
├── user/                   # User-space programs
│   ├── forphan.c          # Vulnerability examples
│   ├── dorphan.c
│   └── ...
├── Makefile               # Build system
└── README.md              # This file
```

## ⚠️ Important Notes

### Educational Use Only
These vulnerabilities are **intentionally** included for educational purposes. This code should:
- ❌ **NEVER** be used in production systems
- ❌ **NEVER** be deployed on public-facing servers
- ✅ **ONLY** be used for learning and research

### Safety
- All exploits run in an isolated QEMU virtual machine
- Your host system remains safe
- GitHub Codespaces provides an additional isolation layer

## 🤝 Contributing

Found a bug or want to add more vulnerability labs? Contributions are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-vuln-lab`)
3. Commit your changes (`git commit -am 'Add new vulnerability lab'`)
4. Push to the branch (`git push origin feature/new-vuln-lab`)
5. Open a Pull Request

## 📝 License

This project maintains the original xv6 license. See `LICENSE` file for details.

xv6 is inspired by Unix V6 and developed by MIT's PDOS group for educational purposes.

## 🙏 Acknowledgments

- MIT PDOS group for creating xv6
- The original Unix V6 creators: Dennis Ritchie and Ken Thompson
- All contributors listed in the original README

## 💬 Support

Having trouble setting up or running the labs?

1. Check the [GitHub Issues](https://github.com/LamaanAliBukhsh/OS_vuln_labs-xv6-riscv-/issues)
2. Read the [Medium article](your-medium-article-link) for detailed explanations
3. Open a new issue if you're stuck

## 🎯 Next Steps

1. **Read the Medium article** to understand the vulnerabilities
2. **Launch GitHub Codespaces** using the badge at the top
3. **Start with Lab 1** and work your way through
4. **Experiment and learn** - break things safely!

Happy hacking! 🚀🔐

---

**Remember:** The goal is to learn about security by understanding how vulnerabilities work, not to cause harm. Always practice responsible disclosure and ethical security research.
