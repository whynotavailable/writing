default:
	git c "tap"
	git push

build:
	fish ./scripts/build.fish

clean:
	rm -rf ./.cache

render:
	rm -rf ./.build
	bun run ./scripts/render.ts ../site
