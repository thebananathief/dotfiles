function which-prompt() {
    $Prompt = $null
    do {
        $Prompt = Read-host "Should I display the file contents c:\test for you? (Y | N)"
    } while ($Prompt -notmatch "^Y|^N")

    Switch ($Prompt) {
        Y {
            "Hello!"
        }
        N {
            "Not Hello!"
        }
    }
}

which-prompt