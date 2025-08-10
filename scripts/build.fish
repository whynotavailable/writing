set cacheDir "./.cache"

mkdir -p "$cacheDir"

# TODO: checkpoint diff this.
for file in (find ./works -name "*.md")
    set targetFile "$(string replace works "$cacheDir/renders" "$file")"
    set targetFile "$(path normalize "$targetFile")"
    set targetFile "$(path change-extension ".html" "$targetFile")"

    mkdir -p "$(path dirname "$targetFile")"
    bun run marked -i "$file" -o "$targetFile"
end

rm -rf "$cacheDir/indexes"
mkdir -p "$cacheDir/indexes"

for file in (find ./.cache/renders -name "*.html")
    set fileParts (string split / $file)
    set categoryIndex "$cacheDir/indexes/$fileParts[-2]"
    set mainIndex "$cacheDir/indexes/main"

    echo $file >>$categoryIndex
    echo $file >>$mainIndex
end

for file in (find ./.cache/indexes -type file)
    bun run ./scripts/process-index.ts "$file"
end
