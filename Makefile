# Lista över konfigurationsfiler och deras destinationer
CONFIG_FILES = \
    ~/.config/pipewire/pipewire.conf.d/raop-discover.conf \
	~/.config/pipewire/pipewire.conf.d/pisound.conf \
	~/.config/pipewire/pipewire.conf.d/custom-sample-rate.conf \
	~/bin/unload-loopbacks.sh \
    ~/.bashrc

# Katalog där vi lagrar backup-filerna
BACKUP_DIR = config-backup

# Skapa backup-mappen om den inte finns
$(shell mkdir -p $(BACKUP_DIR))

# GitHub-repo och token (läses från en miljövariabel)
GIT_REPO = https://$(GITHUB_TOKEN)@github.com/tomeriksen/vinyl-homepod-config.git

backup:
	@echo "Sparar konfigurationsfiler..."
	@for file in $(CONFIG_FILES); do \
		base=$$(basename $$file); \
		cp $$file $(BACKUP_DIR)/$$base; \
	done
	@git add $(BACKUP_DIR)/*
	@git commit -m "Backup av konfigurationsfiler"
	@git push $(GIT_REPO) master

restore:
	@echo "Återställer konfigurationsfiler..."
	@for file in $(CONFIG_FILES); do \
		base=$$(basename $$file); \
		cp $(BACKUP_DIR)/$$base $$file; \
	done

clean:
	@echo "Rensar backup-filer..."
	@rm -rf $(BACKUP_DIR)

