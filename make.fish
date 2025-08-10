set files (find ./complete/ -name "*.md")

for file in $files
    set parts (string split "/" $file)
    set index "$(echo $parts[-2])_index"
    set -a $index $file
end

set readmeFile "README.md"

cat ./README_base.md >$readmeFile
echo "" >>$readmeFile

for index in (set -n | grep _index)
    set indexFile "$index.md"
    set indexParts (string split "_" $index)

    echo "- [$indexParts[1]]($indexFile)" >>$readmeFile

    rm -f "$indexFile"

    for file in $$index
        set baseName "$(path basename $file)"
        echo "- [$baseName]($file)" >>$indexFile
    end
end

# the for loop returns an error cause it's stupid so this makes it work properly
echo done
