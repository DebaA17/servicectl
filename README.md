sudo cp servicectl.sh /usr/local/bin/servicectl
# servicectl 🔧

A simple, user-friendly Bash CLI tool to manage and monitor `systemd` services.

---

## 🚀 Features

- List active services
- Check service status
- Start / Stop / Restart services
- Enable or disable services on boot
- View failed services
- Clean, color-coded CLI output

---

## 📦 Installation

```bash
git clone https://github.com/DebaA17/servicectl.git
cd servicectl
chmod +x servicectl.sh
sudo cp servicectl.sh /usr/local/bin/servicectl
```

---

## 🛠️ Usage

```bash
servicectl list
servicectl status <service>
servicectl start <service>
servicectl stop <service>
servicectl restart <service>
servicectl enable <service>
servicectl disable <service>
servicectl failed
```

**Example:**
```bash
servicectl status ssh
servicectl restart nginx
```

---

## 🤝 Contributing

Contributions are welcome! Please open issues or pull requests.

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.

