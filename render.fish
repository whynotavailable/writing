set oldRef "$(string trim (cat checkpoint 2> /dev/null))"

if test -n "$oldRef"
    set filesToRender (git diff --name-only HEAD $oldRef | grep ".md")
else
    set filesToRender (find works -name "*.md")
end

for file in $filesToRender
    set target "$(path change-extension ".html" "$(string replace works renders "$file")")"
    mkdir -p "$(path dirname "$target")"
    bun run marked -i "$file" -o $target
end

git show-ref --head --hash HEAD >checkpoint
