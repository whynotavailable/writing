default:
	git c "tap"
	git push

build:
	fish ./scripts/build.fish

clean:
	rm -rf ./.cache

render:
	bun run ./scripts/render.ts
