# Architecture

This document describes the high-level architecture of FFG-Idle-Roblox, an idle fishing tycoon game.

## Overview

The game follows a standard Roblox client-server architecture with:
- **Server**: Authoritative game state, data persistence, entity management
- **Client**: UI rendering, input handling, visual effects
- **Shared**: Type definitions, networking contracts, utilities

```
┌─────────────────────────────────────────────────────────────────┐
│                        ROBLOX DATAMODEL                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────────────┐ │
│  │   SERVER    │◄──►│   SHARED    │◄──►│       CLIENT        │ │
│  │             │    │             │    │                     │ │
│  │ • Entities  │    │ • Types     │    │ • React UI          │ │
│  │ • Data      │    │ • Events    │    │ • State Display     │ │
│  │ • Services  │    │ • Atoms     │    │ • Input Handling    │ │
│  │ • Math      │    │ • Networking│    │ • Effects           │ │
│  └─────────────┘    └─────────────┘    └─────────────────────┘ │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Core Concepts

### 1. Entity System (`server/Classes/`)

Game entities are Luau classes representing in-game objects:

| Entity | File | Description |
|--------|------|-------------|
| **Boat** | `Boat.luau` | Fishing boats that passively generate FPS (Fish Per Second) |
| **Helper** | `Helper.luau` | Workers that collect fish from boats to port storage |
| **Tender** | `Tender.luau` | Workers that sell fish from port storage for currency |
| **PortStorage** | `PortStorage.luau` | Central storage building at the dock |
| **Building** | `Building.luau` | Upgradeable structures with various bonuses |
| **Fish** | `Fish.luau` | Individual fish entities from active fishing |

Each entity class follows a consistent pattern:
```luau
-- Entity structure
local Entity = {}
Entity.__index = Entity

function Entity.New(state, player, model, teamId)
    -- Constructor with default state merging
end

function Entity:Purchase() end    -- First-time unlock
function Entity:Upgrade() end     -- Level up
function Entity:Serialize() end   -- Convert to saveable data
function Entity:Save() end        -- Persist to DataStore
function Entity:Destroy() end     -- Cleanup
```

### 2. State Management

#### Server State (Replica Pattern)
Player data uses the **Replica** pattern for server-authoritative state:

```
┌──────────────────┐         ┌──────────────────┐
│  ReplicaServer   │────────►│  ReplicaClient   │
│  (server/Data/)  │         │  (shared/)       │
│                  │         │                  │
│ • Player profile │ Syncs   │ • Read-only view │
│ • Entity states  │────────►│ • UI bindings    │
│ • Progression    │         │                  │
└──────────────────┘         └──────────────────┘
```

#### Client State (Charm Atoms)
UI state uses **Charm** reactive atoms in `shared/Atoms/`:

```luau
-- Atom definition
local balanceAtom = Charm.atom(0)

-- React component usage
local balance = RCharm.useAtom(balanceAtom)
```

### 3. Networking

#### ByteNet Packets (`shared/Networking/`)
High-performance serialized networking for frequent updates:

```luau
-- Packet definition
local Packets = ByteNet.defineNamespace("Game", function()
    return {
        UpdateBalance = ByteNet.definePacket({
            value = ByteNet.types.number,
        }),
    }
end)
```

#### Events (`shared/Events/`)
Traditional RemoteEvents/BindableEvents for less frequent actions:
- Player actions (purchase, upgrade, sell)
- UI interactions
- Server notifications

### 4. Economy System (`server/Math/`)

The economy uses exponential scaling formulas:

#### Cost Formula
```
UpgradeCost = BaseCost × (GrowthRate ^ Level) × TierMultiplier × RealmMultiplier
```

#### FPS (Fish Per Second)
```
CurrentFPS = BaseFPS × LevelMultiplier × BuffMultiplier
```

#### Storage
```
MaxStorage = BaseStorage × (1 + Level × StorageGrowth) × BuffMultiplier
```

#### Buff System (`Math/Buffs.luau`)
Buffs modify entity stats through percentage multipliers:
- `FPS_Percent` - Increases fish generation
- `Storage_Percent` - Increases storage capacity
- `Speed_Percent` - Increases worker movement speed
- `Value_Percent` - Increases fish sale value

### 5. UI Architecture (`client/UI/`)

UI uses **React** with a component hierarchy:

```
App.luau (Root)
├── HUD/
│   ├── TopBar (Currency, settings)
│   ├── BottomBar (Navigation)
│   └── Notifications
├── FishingGame/
│   ├── FishingRod (Active fishing minigame)
│   └── FishCaught (Reward display)
├── Market/
│   └── Shop components
└── Modals/
    └── Various popups
```

### 6. Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                     PLAYER ACTION FLOW                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. Player clicks "Upgrade Boat"                                │
│           │                                                     │
│           ▼                                                     │
│  2. Client fires RemoteEvent                                    │
│           │                                                     │
│           ▼                                                     │
│  3. Server validates request                                    │
│     • Check currency                                            │
│     • Check level cap                                           │
│           │                                                     │
│           ▼                                                     │
│  4. Server updates entity                                       │
│     • Boat:Upgrade()                                            │
│     • Boat:Save()                                               │
│           │                                                     │
│           ▼                                                     │
│  5. Replica syncs new state to client                           │
│           │                                                     │
│           ▼                                                     │
│  6. Charm atoms update                                          │
│           │                                                     │
│           ▼                                                     │
│  7. React UI re-renders                                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## File Organization

### Server (`src/server/`)

| Folder | Purpose |
|--------|---------|
| `Analytics/` | Game analytics and telemetry |
| `Classes/` | Entity class definitions |
| `Classes/Managers/` | Entity lifecycle management |
| `Classes/Modules/` | Shared entity utilities (calculators, visualizers) |
| `Data/` | Player data management (Replica) |
| `Game/` | Game initialization, tutorials |
| `Libs/` | Third-party server libraries |
| `Math/` | Game formulas (Formulas.luau, Buffs.luau) |
| `Modules/` | Utility modules (tweens, UI helpers) |
| `Music/` | Audio management |
| `PlayerState/` | Per-player state tracking |
| `Services/` | Core game services |

### Shared (`src/shared/`)

| Folder | Purpose |
|--------|---------|
| `Atoms/` | Charm reactive state atoms |
| `Enums/` | Game constants (FFGEnum) |
| `Events/` | Remote/Bindable event definitions |
| `Fish/` | Fish data and utilities |
| `GameVersion/` | Version tracking |
| `Networking/` | ByteNet packet definitions |
| `ReplicaShared/` | Shared Replica utilities |
| `Types/` | TypeScript-style type definitions |
| `UI/` | Shared UI utilities (scaling, themes) |
| `Utils/` | General utilities |

### Client (`src/client/`)

| Folder | Purpose |
|--------|---------|
| `Fishing/` | Active fishing minigame |
| `FishingRodShop/` | Rod purchase UI |
| `HUD/` | Heads-up display components |
| `Market/` | Shop and market UI |
| `Notifications/` | Toast/notification system |
| `PlayerState/` | Client-side state management |
| `Satchel/` | Inventory UI |
| `UI/` | React component library |
| `Wind/` | Environmental effects |

## Tier & Realm System

### Tiers
Each entity type has multiple tiers (1, 2, 3...) with increasing costs and rewards:
```luau
TierMultiplier = BaseTierCost ^ (Tier - 1)
```

### Realms
Realms are progression zones that reset and multiply everything:
```luau
RealmMultiplier = BaseRealmCost ^ (RealmId - 1)
```

## Key Patterns

### 1. SECTION Markers
Code uses Better Comments-style section markers for organization:
```luau
-- //SECTION - Constructor
function Entity.New() end
-- //!SECTION
```

### 2. Trove Cleanup
All entities use Trove for deterministic cleanup:
```luau
self._cleaner = Trove.new()
self._cleaner:Add(connection)
-- Later: self._cleaner:Clean()
```

### 3. Type Definitions
Types are defined in `shared/Types/` and imported as needed:
```luau
local BoatType = require(ReplicatedStorage.Shared.Types.Classes.BoatType)
type BoatData = BoatType.BoatData
```
