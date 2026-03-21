# OpenVPN 3 Utility

A simple Makefile wrapper around OpenVPN 3 for managing VPN connections using a single `.ovpn` config.

---

## ✨ Features

* One-command connect / disconnect
* Idempotent config import
* Non-interactive login via credentials file
* No dependency on OpenVPN internal IDs

---

## ⚙️ Setup

### 1. Clone the repo

```bash
git clone <your-repo-url>
cd <repo>
```

---

### 2. Configure environment

Create a .vpn.env` file:

```bash
VPN_CONFIG=$$HOME/vpn/your-config.ovpn
```

---

### 3. Setup credentials

```bash
mkdir -p ~/vpn
printf "<USERNAME>\n<PASSWORD>\n" > ~/vpn/creds
chmod 600 ~/vpn/creds
```

---

### 4. Update your `.ovpn` file

Add this line:

```
auth-user-pass ~/vpn/creds
```

---

## 🚀 Usage

```bash
make connect      # connect to VPN
make disconnect   # disconnect VPN
make status       # show status
make import       # import config
make remove       # remove config
make sessions     # list sessions
make list-configs # list configs
```

---

## ⚠️ Notes

* Only supports **one import per config**
* Do not import the same `.ovpn` multiple times
* Credentials are stored locally — never commit them
* File permissions should be restricted (`chmod 600`)

---

## 🔐 Security

* Credentials are stored in plain text
* Restrict access to the file:

  ```bash
  chmod 600 ~/vpn/creds
  ```
---

## 🧠 Design Philosophy

* Treat `.ovpn` file as the source of truth
* Avoid relying on OpenVPN internal identifiers
* Keep logic simple and predictable

