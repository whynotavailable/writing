default: run
	git c "tap"
	git push

run:
	fish make.fish
