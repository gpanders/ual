function ual --description "Read and edit ual pages"
    if test (count $argv) -lt 1
        echo "Which ual page do you want?"
        return
    end

    set -q ual_path; or set ual_path "$HOME/.notes"

    switch $argv[1]
        case edit
            if test (count $argv) -lt 2
                echo "Which ual page do you want to edit?"
                return
            end
            mkdir -p "$ual_path"
            set note "$ual_path"/$argv[2].md
            if not test -f $note
                printf "# NAME\n\n%s\n" "$argv[2]" > $note
            end
            $EDITOR $note
        case rm
            if test (count $argv) -lt 2
                echo "Which ual page do you want to remove?"
                return
            end
            set note "$ual_path"/$argv[2].md
            if not test -f $note
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
            set note "$ual_path"/$argv[1].md

            if not test -f $note
                echo "No ual entry for $argv[1]" >&2
                return 1
            end

            set title (echo $argv[1] | tr '[:lower:]' '[:upper:]')
            set -q ual_section; or set ual_section "ual"
            set date (date -r $note "+%B %d, %Y")

            pandoc \
                --standalone \
                --to=man \
                --metadata=title:"$title" \
                --metadata=author:"$ual_author" \
                --metadata=section:"$ual_section" \
                --metadata=date:"$date" \
                $note | groff -T utf8 -man | less --squeeze-blank-lines --quit-if-one-screen --no-init
    end
end
