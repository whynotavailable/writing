set cacheDir "./.cache"

mkdir -p "$cacheDir"

# TODO: checkpoint diff this.
for file in (find ./works -name "*.md")
    set category "$(cat "$file" | head -n 1)"
    set targetFile "$(string replace works "$cacheDir/renders/$category" "$file")"
    set targetFile "$(path normalize "$targetFile")"
    set targetFile "$(path change-extension ".html" "$targetFile")"

    mkdir -p "$(path dirname "$targetFile")"
    cat $file | tail -n +3 | bun run marked -o "$targetFile"

    set stubFile "$(path normalize "$file")"
    set stubFile "$(path change-extension ".txt" "$stubFile")"
    if test -e "$stubFile"
        set targetStubFile "$(string replace works "$cacheDir/renders/$category" "$stubFile")"
        cp "$stubFile" "$targetStubFile"
    end
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
    bun run ./scripts/build.ts "$file.json"
end
