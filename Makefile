# Lista över konfigurationsfiler och deras destinationer
CONFIG_FILES = \
    ~/.config/pipewire/pipewire.conf.d/raop-discover.conf \
	~/.config/pipewire/pipewire.conf.d/pisound.conf \
	~/.config/pipewire/pipewire.conf.d/custom-sample-rate.conf \
	~/bin/unload-loopbacks.sh \
    ~/.bashrc \
	/usr/local/bin/flash_pisound_leds.sh \
	/etc/wireplumber/main.lua.d/99-pisound-lock.lua \
    ~/.config/systemd/user/audio-router.service
# Katalog där vi lagrar backup-filerna
BACKUP_DIR = config-backup

# Skapa backup-mappen om den inte finns
$(shell mkdir -p $(BACKUP_DIR))

# GitHub-repo och token (läses från en miljövariabel)
GIT_REPO = https://$(GITHUB_TOKEN)@github.com/tomeriksen/vinyl-homepod-config.git

backup:
	@set -e  # Stoppa make om något kommando misslyckas

	@echo "Sparar konfigurationsfiler..."
	@for file in $(CONFIG_FILES); do \
		base=$$(basename $$file); \
		cp $$file $(BACKUP_DIR)/$$base; \
	done
	@git add $(BACKUP_DIR)/*
	@git add -A
	@if ! git diff-index --quiet HEAD; then \
		git commit -m "Backup av konfigurationsfiler"; \
	fi
	@if git log origin/master..HEAD --oneline | grep .; then \
		echo "Ange din GitHub token: "; \
		TOKEN=$$(bash -c 'read -s -p "Token: " t && echo $$t'); \
		echo "Pushar nya commits..."; \
		git push https://$$TOKEN@github.com/tomeriksen/vinyl-homepod-config.git master; \
	else \
		echo "Inget nytt att pusha."; \
	fi

restore:
	@echo "Återställer konfigurationsfiler..."
	@for file in $(CONFIG_FILES); do \
		base=$$(basename $$file); \
		cp $(BACKUP_DIR)/$$base $$file; \
	done

clean:
	@echo "Rensar backup-filer..."
	@rm -rf $(BACKUP_DIR)

