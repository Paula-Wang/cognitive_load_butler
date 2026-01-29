<div align="center">

# 🧠✨ Cognitive Load Butler
**"Your Personal Gentleman's Gentleman for Mental Energy Management"**

[![Built with Serverpod](https://img.shields.io/badge/Backend-Serverpod-blue?style=for-the-badge&logo=dart)](https://serverpod.dev)
[![Built with Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Hackathon](https://img.shields.io/badge/Hackathon-Serverpod%20Butler-orange?style=for-the-badge)](https://devpost.com)

---

### 🛡️ Guarding your Focus. Managing your Load. 
Traditional to-do apps are digital debt. The **Cognitive Load Butler** treats your mental energy as a finite resource, acting as a buffer between you and your overwhelming backlog.

[Features](#-key-features) • [The Algorithm](#-the-butler-algorithm) • [Tech Stack](#-tech-stack) • [Quick Start](#-quick-start)

</div>

---

## 🚀 Key Features

* **⚡ Dynamic Task Management:** Add tasks with custom sliders for **Importance** and **Mental Load**.
* **🎯 Today’s High-Impact Focus:** The Butler segregates your messy backlog into a curated "Top Priority" area.
* **🔔 Native Butler Nudges:** Desktop notifications that celebrate completions and warn of high-impact tasks.
* **📌 Visual Pinning:** Automatic highlighting of "Quick Wins"—tasks that are high importance but low mental effort.

---

## 🧮 The Butler Algorithm
The Butler doesn't just list tasks; he calculates their true cost to your day.

$$Score = (Importance \times 3) - Mental Load$$

| Score | Meaning | Visual Cue |
| :--- | :--- | :--- |
| **8+** | **High Impact Quick-Win** | Pinned & Green Card |
| **1-7** | **Standard Priority** | Standard Card |
| **< 0** | **Cognitive Drainer** | Deprioritized |

---

## 🛠 Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Frontend** | Flutter Web (Sticky Note Design System) |
| **Backend** | Serverpod (Dart-based Backend) |
| **APIs** | Native Web Notification API |
| **DevOps** | Docker-compose for local Serverpod logic |

---

## 🏃 Quick Start

### 1. Start the Server
```bash
cd server
docker-compose up --build
dart bin/main.dart
2. Launch the Butler (Web)
Bash
cd cognitive_load_butler_flutter
flutter run -d chrome
<div align="center">
Built with ❤️ for the 2026 Serverpod Butler Hackathon.
</div>
