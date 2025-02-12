# #  Raspberry Pi Audio Config Dokumentation

##  Systeminformation
- **Raspberry Pi Model:** Pi 4B
- **OS:** Raspberry Pi OS (Bookworm)
- **Ljudsystem:** PipeWire + RAOP (AirPlay)

##  Viktiga Konfigurationsfiler
| Fil                                   | Syfte                    | Ändrad? |
|---------------------------------------|--------------------------|---------|
| `/etc/pipewire/pipewire.conf`         | PipeWire huvudkonfig     | J       |
| `~/.config/pipewire/pipewire.conf.d/` | Anpassad PipeWire-konfig | J       |
| `~/.config/pipewire/pipewire.conf.d/raop-discover.conf` | RAOP-modul | J       |
| `/etc/pulse/daemon.conf`              | PulseAudio sample rate   | N       |
| `/etc/asound.conf`                    | ALSA ljudinst�llningar  | N       |
| `~/.asoundrcc`                        | Personlig ALSA-konfig    | N       |
| `/boot/config.txt`                    | Styra Pisound vid boot   | N       |
| `~/.bashrc`				| Extra commandon	| Y	|

##  Funktioner
| Fil                                   | Syfte                    	| Ändrad? |
|---------------------------------------|--------------------------	|---------|
| `/bin/unload-loopbacks.sh`         	| Ta bort koppling från pisound	| J       |


## Gjorda ändringar
###  **PipeWire Sample Rate**
- **Fil:** `/etc/pipewire/pipewire.conf`
- **Ändrad från:** `48000` ? `96000`
- **Kommandon för att fixa:**
  ```bash
  sudo nano /etc/pipewire/pipewire.conf
  # ändra default.sample-rate = 96000 tillbaka till 48000

### Upptäcka airtunes enheter
- **Fil**: `~/.config/pipewire/pipewire.conf.d/raop-discover.conf`
- **Förändring** : La till `libpipewire-module-raop-discover`som pipewire-module

### Extra commandon `~/.bashrc`
- pisound-sources: Listar pisounds in och utkanal i behändit format
- 
