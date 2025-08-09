set files (find ./complete/ -name "*.md")

for file in $files
    set tag "$(head -n 1 $file)"

    set index "$(echo $tag)_index"

    set -a $index "$file"
end

set readmeFile "README.md"

cat ./README_base.md >$readmeFile
echo "" >>$readmeFile

for index in (set -n | grep _index)
    set indexFile "$index.md"

    echo "- [$index]($indexFile)" >>$readmeFile

    rm -f "$indexFile"

    for file in $$index
        echo "- [$file]($file)" >>$indexFile
    end
end
