# Lista över konfigurationsfiler
CONFIG_FILES = \
    /etc/pipewire/pipewire.conf \
    ~/.config/pipewire/pipewire.conf.d/raop-discover.conf \
    ~/.bashrc

# Katalog för backup-filer
BACKUP_DIR = config-backup

# GitHub-repo och token
GIT_REPO = https://$(GITHUB_TOKEN)@github.com/tomeriksen/vinyl-homepod-config.git

# Skapa backup-mappen om den inte finns
$(shell mkdir -p $(BACKUP_DIR))

backup:
	@echo "Sparar konfigurationsfiler..."
	@for file in $(CONFIG_FILES); do \
		base=$$(basename $$file); \
		cp $$file $(BACKUP_DIR)/$$base; \
	done
	@git add -A  # Lägg till ALLA ändringar, även Makefile
	@if ! git diff-index --quiet HEAD; then \
		git commit -m "Backup av konfigurationsfiler"; \
	fi
	@if git log origin/master..HEAD --oneline | grep .; then \
		echo "Pushar nya commits..."; \
		git push $(GIT_REPO) master; \
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
