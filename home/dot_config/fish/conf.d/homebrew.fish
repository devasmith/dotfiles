# Put Homebrew on PATH (macOS only, ignored on Linux)
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew
    if test -x $brew
        $brew shellenv fish | source
        break
    end
end
