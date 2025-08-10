for dir in (find works -type directory | grep "/")
    set base (path basename "$dir")

    set indexFile "indexes/$base.md"

    rm -f $indexFile

    for file in (find "works/$base" -name "*.md" | sort -r)
        set fileName (path basename $file)
        echo "- [$fileName](../$file)" >>$indexFile
    end
end
