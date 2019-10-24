function ual --description "Read and edit ual pages"
    if test (count $argv) -lt 1
        echo "Which ual page do you want?"
        return
    end

    set -q ual_path
    or set ual_path "$HOME/.notes"
    set -q ual_ext
    or set ual_ext md

    switch $argv[1]
        case edit
            if test (count $argv) -lt 2
                echo "Which ual page do you want to edit?"
                return
            end
            mkdir -p "$ual_path"
            set note "$ual_path"/*$argv[2]*
            if test (count $note) -gt 1
                # TODO: Prompt for selection
                echo "Found multiple matches:"\n $note\n
                return 1
            end
            if test -z $note
                set note "$ual_path"/$argv[2].$ual_ext
                printf "# NAME\n\n%s\n" "$argv[2]" >$note
            end
            $EDITOR $note
        case rm
            if test (count $argv) -lt 2
                echo "Which ual page do you want to remove?"
                return
            end
            set note "$ual_path"/*$argv[2]*
            if test (count $note) -gt 1
                # TODO: Prompt for selection
                echo "Found multiple matches:"\n $note\n
                return 1
            end
            if test -z $note
                echo "No ual entry for $argv[2]" >&2
                return 1
            end
            rm $note
        case ls
            printf "%s\n" (command ls $ual_path | sed 's/\.[^.]*$//')
        case sync
            echo -n "Syncing notes... "
            cd "$ual_path"
            and git pull >/dev/null 2>&1
            and git add .
            and git commit --dry-run >/dev/null 2>&1
            and git commit --quiet --verbose 2>/dev/null
            and git push >/dev/null 2>&1
            and cd -
            echo "Done."
        case '*'
            set -l extensions $ual_ext md scd
            for ext in $extensions
                if test -f "$ual_path"/$argv[1].$ext
                    set note "$ual_path"/$argv[1].$ext
                    break
                end
            end

            if not test -f $note
                echo "No ual entry for $argv[1]" >&2
                return 1
            end

            if begin
                    test $ext = "md" && not command -sq pandoc
                end
                or begin
                    test $ext = "scd" && not command -sq scdoc
                end
                echo "Formatter for filetype $ext not found; displaying note unformatted..." >&2
                eval "$PAGER $note"
                return 0
            end

            set -l tmp (mktemp)

            switch $ext
                case md
                    set -l title (echo $argv[1] | tr '[:lower:]' '[:upper:]')
                    set -q ual_section
                    or set ual_section "ual"
                    set date (date -r $note "+%B %d, %Y")

                    pandoc \
                        --standalone \
                        --to=man \
                        --metadata=title:"$title" \
                        --metadata=author:"$ual_author" \
                        --metadata=section:"$ual_section" \
                        --metadata=date:"$date" \
                        --output=$tmp \
                        $note
                case scd
                    set -q ual_author
                    and set author (printf "# AUTHOR\n%s\n" $ual_author)
                    echo \n$author | cat $note - | scdoc >$tmp
            end

            man $tmp
            rm -f $tmp
    end
end
