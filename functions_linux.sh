#!/usr/bin/env bash

pg_face_init () {
    $pg_face_hide_cursor && unclutter -display $pg_face_display_num -root -idle 0.1 & # hide cursor if not used for 0.1 secs
}

pg_face_show () {
    local previous_face_pid="$(pgrep gifview)"
    gifview --title "Jarvis" \
            --display $pg_face_display_num \
            --geometry $pg_face_size$pg_face_x_offset$pg_face_y_offset \
            --animate \
            --no-interactive "$1" & # opens new window on top
    if [ -n "$previous_face_pid" ]; then
        (
            sleep 0.5 # because above (new) window takes time to open before below (previous) is closed
            kill $previous_face_pid 2>/dev/null # closes previous window behind
            #wait $previous_face_pid 2>/dev/null # to suppress Terminated messages
        ) & # sleep not blocking
    fi
}

pg_face_exit () {
    killall -q gifview
    $pg_face_hide_cursor && killall -q unclutter # show back cursor if chosen to hide it
}
