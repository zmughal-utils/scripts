define shell_frag_PACKAGE_NAMES_0 :=
find . -mindepth 1 -maxdepth 1 -type d \! -name '.*' -printf '%f\0'
endef

list-packages:
	@$(shell_frag_PACKAGE_NAMES_0) \
		| xargs -0 \
			echo

stow-dry-run:
	$(shell_frag_PACKAGE_NAMES_0) \
		| xargs -0 \
			stow -n -v -S

stow:
	$(shell_frag_PACKAGE_NAMES_0) \
		| xargs -0 \
			stow -v -S
