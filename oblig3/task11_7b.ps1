
# Print menu and read menu choice
function doMenu() {

    Write-Host @"
1 - Hvem er jeg og hva er navnet på dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og tråder finnes?
4 - Hvor mange context switch'er fant sted siste sekund?
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
6 - Hvor mange interrupts fant sted siste sekund?
9 - Avslutt dette scriptet`n
"@

    return Read-Host "Velg en funksjon: "
}

# Read initial menu choice
$ans = doMenu

# While not chosen 9 -> do chosen menu action
while ($ans -ne "9") {

    switch ($ans) {
        1 { Write-Host "You pressed 1" }
        2 { Write-Host "You pressed 2" }
        3 { Write-Host "You pressed 3" }
        4 { Write-Host "You pressed 4" }
        5 { Write-Host "You pressed 5" }
        6 { Write-Host "You pressed 6" }
        9 { Write-Host "You pressed 9" }
        default { Write-Host "$ans ????" }

    }

    # Read menu choice
    $ans = doMenu
}
