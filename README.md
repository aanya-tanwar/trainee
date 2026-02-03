# Trainee Project

This is a full-stack project that consists of both a **Frontend** and **Backend**. The project provides a simple "Welcome" page, where the frontend is built with **HTML & CSS** and the backend is built with **Node.js** and **Express**.

---

## Prerequisites

Before running this project, ensure that you have the following installed on your machine:

- **Node.js** (with npm)
  - Download and install it from [Node.js official website](https://nodejs.org/).
- **Git**
  - Install it from [Git official website](https://git-scm.com/).

---

## VM Details Script

This repository includes a shell script (`get_vm_details.sh`) that retrieves and displays comprehensive information about the VM/system where it's running.

### Features

The script collects and displays:
- Hostname and FQDN
- Operating system information
- CPU details (model, cores, threads)
- Memory usage (total, used, free, available)
- Disk space information
- Network information (IP addresses, interfaces)
- System uptime and load average
- Date/time information
- Logged in users
- Virtualization type (if applicable)

### Usage

To run the script:

```bash
./get_vm_details.sh
```

Make sure the script has executable permissions. If not, run:

```bash
chmod +x get_vm_details.sh
```

---
