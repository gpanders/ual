function _ual() {
    local state

    _arguments \
        '1: :->subcmd' \
        '2: :->arg'

    local -a notes
    notes=("${UAL_PATH:-$HOME/.notes}"/*(:t:r))

    case $state in
        subcmd)
            local -a subcmds
            subcmds=(
                'edit:Create or edit the given note'
                'rm:Remove the given note'
                'ls:List all notes'
                'sync:Synchronize notes'
            )
            _describe 'command' subcmds

            compadd $notes
            ;;
        arg)
            case $line[1] in
                rm|edit) compadd $notes ;;
            esac
            ;;
    esac
}

function ual() {
    if [ $# -lt 1 ]; then
        echo "Which ual page do you want?"
        return
    fi

    NOTES="${UAL_PATH:-$HOME/.notes}"

    case "$1" in
        edit)
            if [ $# -lt 2 ]; then
                echo "Which ual page do you want to edit?"
                return
            fi
            mkdir -p "$NOTES"
            NOTE="$NOTES"/$2.md
            if [ ! -f "$NOTE" ]; then
                echo "# NAME\n\n$2\n" > "$NOTE"
            fi
            ${EDITOR:-vi} "$NOTE"
            ;;
        rm)
            if [ $# -lt 2 ]; then
                echo "Which ual page do you want to remove?"
                return
            fi
            NOTE="$NOTES"/$2.md
            if [ ! -f "$NOTE" ]; then
                echo "No ual entry for $1" >&2
                return 1
            fi
            rm "$NOTE"
            ;;
        ls)
            for note in "$NOTES"/*; do echo "${${note##*/}%.*}"; done
            ;;
        sync)
            echo -n "Syncing notes... "
            (cd "$NOTES" && \
                git pull &>/dev/null && \
                git add . && \
                git commit --dry-run &>/dev/null && \
                git commit --quiet --verbose 2>/dev/null && \
                git push &>/dev/null)
            echo "Done."
            ;;
        *)
            NOTE="$NOTES"/$1.md

            if [ ! -f "$NOTE" ]; then
                echo "No ual entry for $1" >&2
                return 1
            fi

            TITLE="$(echo $1 | tr '[:lower:]' '[:upper:]')"
            SECTION="${UAL_SECTION:-ual}"
            AUTHOR="$UAL_AUTHOR"
            DATE="$(date +'%B %d, %Y' -r "$NOTE")"

            pandoc \
                --standalone \
                --to=man \
                --metadata=title:"$TITLE" \
                --metadata=author:"$AUTHOR" \
                --metadata=section:"$SECTION" \
                --metadata=date:"$DATE" \
                "$NOTE" | groff -T utf8 -man | less --squeeze-blank-lines --quit-if-one-screen --no-init
            ;;
    esac
}

compdef _ual ual
