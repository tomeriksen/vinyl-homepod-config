# #  Raspberry Pi Audio Config Dokumentation

##  Systeminformation
- **Raspberry Pi Model:** Pi 4B
- **OS:** Raspberry Pi OS (Bookworm)
- **Ljudsystem:** PipeWire + RAOP (AirPlay)

##  Viktiga Konfigurationsfiler
| Fil                                   | Syfte                    | Ändrad? |
|---------------------------------------|--------------------------|---------|
| `/etc/pipewire/pipewire.conf`         | PipeWire huvudkonfig     | N       |
| `~/.config/pipewire/pipewire.conf.d/` | Anpassad PipeWire-konfig-dir | J       |
| `~/.config/pipewire/pipewire.conf.d/raop-discover.conf` | RAOP-modul | N      |
| `~/.config/pipewire/pipewire.conf.d/custom-sample-rate.conf` | Sätter sample rates för pw | J       |

| `/etc/wireplumber/main.lua.d/99-pisound-lock.lua`       | Tvingar pisound till 96kHz   | J       |
| `/etc/pulse/daemon.conf`              | PulseAudio sample rate   | N       |
| `/etc/asound.conf`                    | ALSA ljudinst�llningar  | N       |
| `~/.asoundrcc`                        | Personlig ALSA-konfig    | N       |
| `/boot/config.txt`                    | Styra Pisound vid boot   | N       |
| `~/.bashrc`				| Extra kommandon	| Y	|

##  Funktioner
| Fil                                   | Syfte                    	|
|---------------------------------------|--------------------------	|
| `/bin/unload-loopbacks.sh`         	| Ta bort koppling från pisound	|
| `~/.config/systemd/user/audio-router.service`	|  startar upp audi-router vid uppstart	|
| `/usr/local/bin/flash_pisound_leds.sh`         	| Flashar Leds på Pisound-kortet	|


## Gjorda ändringar
###  **PipeWire Sample Rate**
- **Fil:** `/etc/wireplumber/main.lua.d/99-pisound-lock.lua`
- **Syfte:** Regel som ser till att wireplumber sätter pisound-noders sample rate till `96000`



### Upptäcka airtunes enheter
- **Fil**: `~/.config/pipewire/pipewire.conf.d/raop-discover.conf`
- **Förändring** : La till `libpipewire-module-raop-discover`som pipewire-module
BORTKOMMENTERAD. Jag har flytatt över detta till RPI_Turntables python-kod istället

### Extra commandon `~/.bashrc`
- pisound-sources: Listar pisounds in och utkanal i behändit format
- 

### Serviceinställningar
`systemctl --user enable audio-router.service`
` loginctl enable-linger $(whoami)`
Why?
*enable-linger ensures that user services start at boot, even without an active login session.*
