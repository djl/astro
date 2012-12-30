--
-- rio
--
set res to do shell script "rio"
set app_name to displayed name of (info for path to frontmost application)
set short_name to short name of (info for (path to frontmost application))
set canonical_name to do shell script "echo '" & short_name & "' | sed 's/[[:space:]]/-/g'"
set bounds_ to do shell script "rio " & canonical_name & " " & res

if not (bounds_ = "") then
    set width to (word 1 of bounds_) as integer
    set height to (word 2 of bounds_) as integer
    set x to (word 3 of bounds_) as integer
    set y to (word 4 of bounds_) as integer

    tell application app_name
        try
            set allWindows to every window
            repeat with wind in allWindows
                if wind is closeable and wind is resizable then
                    set the bounds of wind to {x, y, width, height}
                    exit repeat
                end if
            end repeat
        end try
    end tell
end if
