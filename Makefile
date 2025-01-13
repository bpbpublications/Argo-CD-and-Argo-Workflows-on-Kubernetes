# add build to the default target

.PHONY: build generate-completions install-completions install-bash-completion install-zsh-completion


build:
	@docker info > /dev/null 2>&1 || (echo "Docker is not running or installed. Please install and start docker" && exit 1)
	docker run --platform "linux/amd64" --rm -it --user $(id -u):$(id -g) --volume "$(shell pwd):/app" dannyben/bashly generate
run:
	./miniargo


# notes this need bash 4 or higher
# in mac os you can install it with 
# brew install bash

install-bash:
	brew install bash

install-kustomize:
	brew install kustomize


install-argo:
	brew install argocd

install-argocd-kubectl-extensions:
	brew install argoproj/tap/kubectl-argo-rollouts


generate-completions:
	@mkdir -p $(COMPLETION_DIR)
	@./miniargo completion > $(COMPLETION_DIR)/miniargo.sh

install-completions: generate-completions install-bash-completion install-zsh-completion

install-bash-completion: generate-completions
	@if [ -d "$(BASH_COMPLETION_DIR)" ]; then \
		cp $(COMPLETION_DIR)/miniargo.sh $(BASH_COMPLETION_DIR)/miniargo; \
		echo "Bash completion installed. Please restart your shell or run 'source $(BASH_COMPLETION_DIR)/miniargo'"; \
	else \
		echo "Bash completion directory not found. Please install bash-completion."; \
	fi

install-zsh-completion: generate-completions
	@if [ -d "$(ZSH_COMPLETION_DIR)" ]; then \
		cp $(COMPLETION_DIR)/miniargo.sh $(ZSH_COMPLETION_DIR)/_miniargo; \
		echo "Zsh completion installed. Please restart your shell or run 'source $(ZSH_COMPLETION_DIR)/_miniargo'"; \
	else \
		echo "Zsh completion directory not found. Please check your Zsh configuration."; \
	fi

