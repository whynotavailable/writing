default:
	fish make.fish
tap: default
	git c "tap"
	git push
