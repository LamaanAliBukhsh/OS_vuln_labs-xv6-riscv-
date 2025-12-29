xv6 OS VULNERABILITY LABS
=========================

Two CTF-style challenges for learning OS exploitation basics.

SETUP:
- Build: make qemu (in WSL/Linux)
- Execute:
  sudo apt-get install -y qemu-system-misc
  make qemu
- Run exploits in xv6 shell
- To exit: Cntrl+A -> X

LAB 1: Buffer Overflow
- Exploit missing bounds check
- Run: exp1

LAB 2: Privilege Escalation  
- Exploit logical operator bug
- Run: exp2

FLAGS:
- Lab 1: FLAG{xv6_buff3r_0verfl0w_m4st3r_LAB1}
- Lab 2: FLAG{pr1v_3sc_g0t_r00t_acc3ss_LAB2}

See LAB1.txt and LAB2.txt for hints.
