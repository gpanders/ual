function __ual_complete_notes
    set -q UAL_PATH; or set -l UAL_PATH "$HOME/.notes"
    printf "%s\n" (command ls $UAL_PATH | sed 's/\.[^.]*$//')
end

complete -k -x -c ual -n '__fish_seen_subcommand_from rm edit' -a '(__ual_complete_notes)'
complete -k -x -c ual -n '__fish_seen_subcommand_from sync ls'
complete -k -x -c ual -n '__fish_use_subcommand' -a '(__ual_complete_notes)'
complete -k -x -c ual -n '__fish_use_subcommand' -a 'rm' -d 'Remove a note'
complete -k -x -c ual -n '__fish_use_subcommand' -a 'ls' -d 'List all notes'
complete -k -x -c ual -n '__fish_use_subcommand' -a 'edit' -d 'Edit a note'
complete -k -x -c ual -n '__fish_use_subcommand' -a 'sync' -d 'Synchronize notes'
