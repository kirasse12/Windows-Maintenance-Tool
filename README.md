# 🖥️ Windows Maintenance Tool

![Version](https://img.shields.io/badge/version-v2.9.6-green)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![License: MIT](https://img.shields.io/badge/license-MIT-blue)

A powerful, all-in-one Windows maintenance toolkit built entirely in Batch.  
Designed for power users, sysadmins, and curious tinkerers – now smarter, safer, and fully offline-compatible.

---

## 📸 Screenshot

![3917ac484c3a7820324d7610c85587be](https://github.com/user-attachments/assets/cc2a0fb7-6621-4fbf-8e2b-f5e4c06e7123)



---

## ✅ Features

- Run essential repair tools: `SFC`, `DISM`, `CHKDSK`
- Windows Update via `winget` (interactive selection added in v2.9.5)
- View and upgrade individual packages instead of forced `--all`
- Network diagnostics: `ipconfig`, `route print`, `nslookup`
- DNS configuration (Google, Cloudflare, or custom)
- Clean temp files, logs, and browser cache
- Save detailed reports to Desktop:
  - System Info
  - Network Info
  - Driver List
- Registry tools:
  - Safe cleanup & backup
  - Corruption scan
- Fully menu-driven interface with clean output
- No third-party dependencies required

---

## ⚙️ Installation

1. Download the `.bat` file.
2. **Right-click → Run as Administrator** (auto-elevation supported).
3. Follow the interactive menu.

> ⚠️ Script output may appear in your system language (e.g. English, Danish, etc). This is normal.

---

## 📁 Output Files

Saved directly to your Desktop:

- `System_Info_YYYY-MM-DD.txt`
- `Network_Info_YYYY-MM-DD.txt`
- `Driver_List_YYYY-MM-DD.txt`
- `routing_table_YYYY-MM-DD.txt` *(new in v2.9.5)*

---

## 🧪 Troubleshooting & FAQ

**Q: The script didn’t restart as Admin?**  
A: Make sure UAC is enabled. Right-click and select **Run as Administrator**.

**Q: Why does it crash when selecting winget upgrades?**  
A: Fixed in v2.9.5 – now fully input-validated and error-handled.

**Q: Why was Registry Defrag removed?**  
A: The feature depended on a third-party tool (NTREGOPT) which is no longer accessible.  
The script is now fully offline and native to Windows.

---

## ✍️ Changelog (v2.9.6)

- 🛠 Fixed crash in `choice10` (CHKDSK scan)
- 🔍 CHKDSK now targets only valid file system drives using PowerShell
- ✅ Improved drive filtering for better compatibility on systems with external or locked volumes
- 🧪 Rewrote scanning logic to support multi-partition setups
- 🧼 Cleaned up CMD prompt formatting (replaced smart quotes, ensured ASCII-safe output)

---

## 🤝 Contributing

Pull requests, issues, and feedback are welcome!  
See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📜 License

Licensed under the MIT License. See [`LICENSE`](LICENSE) for full details.

---

## 🔗 Related Projects

- [🍎 MSS – Mac Service Script](https://github.com/ios12checker/MSS-Mac-Service-Script)
