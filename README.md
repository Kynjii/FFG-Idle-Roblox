# FFG-Idle-Roblox

An idle fishing tycoon game built on Roblox using modern Luau tooling and React-based UI.

## 🎮 Game Overview

Players build and manage a fishing empire by:

- **Purchasing boats** that passively catch fish (FPS - Fish Per Second)
- **Hiring helpers** to automate fish collection and sales
- **Upgrading equipment** to increase efficiency and storage
- **Unlocking new tiers** and realms for exponential progression
- **Active fishing minigame** for bonus rewards

## 🏗️ Architecture

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed system documentation.

```
src/
├── client/          # Client-side scripts (UI, input, effects)
├── server/          # Server-side scripts (game logic, data)
├── shared/          # Shared modules (types, networking, utilities)
└── repFirst/        # ReplicatedFirst scripts (loading screen)
```

### Core Systems

| System              | Location             | Description                                     |
| ------------------- | -------------------- | ----------------------------------------------- |
| **Entity Classes**  | `server/Classes/`    | Boat, Helper, Tender, Building, Fish entities   |
| **Data Management** | `server/Data/`       | Player data persistence with Replica pattern    |
| **Economy Math**    | `server/Math/`       | Formulas for costs, FPS, storage, buffs         |
| **State Atoms**     | `shared/Atoms/`      | Reactive state management with Charm            |
| **Networking**      | `shared/Networking/` | ByteNet packets for client-server communication |
| **React UI**        | `client/UI/`         | Declarative UI components                       |

## 📦 Dependencies

| Package                                             | Purpose                                   |
| --------------------------------------------------- | ----------------------------------------- |
| [React](https://github.com/jsdotlua/react-lua)      | Declarative UI framework                  |
| [Charm](https://github.com/littensy/charm)          | Reactive state atoms                      |
| [CharmSync](https://github.com/littensy/charm-sync) | Server-client state synchronization       |
| [ByteNet](https://github.com/ffrostflame/ByteNet)   | High-performance networking/serialization |
| [Trove](https://github.com/sleitnick/Trove)         | Instance/connection cleanup utility       |
| [Signal](https://github.com/sleitnick/Signal)       | Custom signal/event implementation        |
| [Sift](https://github.com/csqrl/sift)               | Immutable table utilities                 |
| [Ripple](https://github.com/littensy/ripple)        | UI animation library                      |
| [Satchel](https://github.com/RyanLua/Satchel)       | Inventory/backpack system                 |
| [UI-Labs](https://github.com/PepeElToro41/ui-labs)  | UI component development/testing          |

## 🚀 Getting Started

### Prerequisites

1. **Install [Rokit](https://github.com/rojo-rbx/rokit)** (recommended) or [Aftman](https://github.com/LPGhatguy/aftman):

    ```bash
    # Rokit (recommended)
    rokit install

    # Or Aftman
    aftman install
    ```

2. **Install dependencies with Wally**:
    ```bash
    wally install
    ```

### Development

1. **Build the place file**:

    ```bash
    rojo build -o "FFG-Idle-Roblox.rbxlx"
    ```

2. **Open in Roblox Studio** and start the Rojo server:

    ```bash
    rojo serve
    ```

3. **Connect Rojo plugin** in Studio to sync changes live.

### Tooling

| Tool                                                  | Config File            | Purpose                      |
| ----------------------------------------------------- | ---------------------- | ---------------------------- |
| [Rojo](https://rojo.space/)                           | `default.project.json` | File sync with Roblox Studio |
| [Wally](https://wally.run/)                           | `wally.toml`           | Package management           |
| [Selene](https://kampfkarren.github.io/selene/)       | `selene.toml`          | Linting                      |
| [StyLua](https://github.com/JohnnyMorganz/StyLua)     | `stylua.toml`          | Code formatting              |
| [Luau LSP](https://github.com/JohnnyMorganz/luau-lsp) | `luau-lsp.toml`        | Language server              |

## 📁 Project Structure

```
FFG-Idle-Roblox/
├── src/
│   ├── client/                 # StarterPlayerScripts
│   │   ├── app.luau            # React app root
│   │   ├── root.client.luau    # Client entry point
│   │   ├── Fishing/            # Fishing minigame client
│   │   ├── HUD/                # HUD components
│   │   ├── UI/                 # React UI components
│   │   └── ...
│   ├── server/                 # ServerScriptService
│   │   ├── Classes/            # Entity class definitions
│   │   │   ├── Boat.luau       # Fishing boat entity
│   │   │   ├── Helper.luau     # Fish collection helper
│   │   │   ├── Tender.luau     # Fish selling tender
│   │   │   └── ...
│   │   ├── Data/               # Data management (Replica)
│   │   ├── Math/               # Game formulas and calculations
│   │   ├── Services/           # Game services
│   │   └── ...
│   ├── shared/                 # ReplicatedStorage
│   │   ├── Atoms/              # Charm state atoms
│   │   ├── Enums/              # Game constants and enums
│   │   ├── Events/             # Remote/Bindable events
│   │   ├── Networking/         # ByteNet packet definitions
│   │   ├── Types/              # TypeScript-style type definitions
│   │   └── ...
│   └── repFirst/               # ReplicatedFirst
│       └── LoadingScreen.client.luau
├── Packages/                   # Wally packages (git-ignored contents)
├── default.project.json        # Rojo project config
├── wally.toml                  # Wally dependencies
└── ...
```

## 📄 License

MIT © Dean Burrows (2026)
