--
-- rio
--
set path_ to "" & (path to home folder) & ".rio"

on lower(this_text)
    set the comparison_string to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    set the source_string to "abcdefghijklmnopqrstuvwxyz"
    set the new_text to ""
    repeat with thisChar in this_text
        set x to the offset of thisChar in the comparison_string
        if x is not 0 then
            set the new_text to (the new_text & character x of the source_string) as string
        else
            set the new_text to (the new_text & thisChar) as string
        end if
    end repeat
    return the new_text
end change_case

on slurp(theFile)
    set fileHandle to open for access theFile
    set theLines to paragraphs of (read fileHandle)
    close access fileHandle
    return theLines
end fileToList

on replace(input, x, y)
    set text item delimiters to x
    set ti to text items of input
    set text item delimiters to y
    ti as text
end replace

tell application "Finder"
    set fbounds to bounds of window of desktop
end tell

set lines_ to slurp(path_)
set res to "" & (item 3 of fbounds) & "x" & (item 4 of fbounds)
set app_name to short name of (info for (path to frontmost application))
set needle to replace(app_name, " ", "-")
set needle to lower(needle)

repeat with line_ in lines_
    try
        if (word 1 of line_) is equal to needle then
            if (word 2 of line_) is equal to res then
                set width to (word 3 of line_) as integer
                set height to (word 4 of line_) as integer
                set x to (word 5 of line_) as integer
                set y to (word 6 of line_) as integer

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
        end if
    end try
end repeat
