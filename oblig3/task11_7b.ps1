
# Print menu and read menu choice
function doMenu() {

    Write-Output @"

1 - Hvem er jeg og hva er navnet paa dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og traader finnes?
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
        1 { 
            $username=$env:username
            $scriptName=$MyInvocation.MyCommand.Name
            Write-Output "Jeg er $username, og navnet paa dette scriptet er $scriptName"
        }
        2 { 
            $bootTime=((Get-CimInstance Win32_OperatingSystem).LastBootUpTime)
            $nowTime=(Get-Date)
            $elapsedTimeString=(New-Timespan -Start $bootTime -End $nowTime)
            Write-Output "Tid siden siste boot: $elapsedTimeString" 
        }
        3 { 

            
            # found with `(Get-WmiObject Win32_OperatingSystem) 
            # | Get-Member | Where-Object { $_.Name -match "process" }`
            $numProcesses=((Get-CimInstance Win32_OperatingSystem).NumberOfProcesses)

            $numThreads=((Get-CimInstance Win32_Thread).Count)



            Write-Output "Der er $numProcesses prosesser og $numThreads traader" 
        }
        4 { 

            # found with `(Get-CimInstance 
            # Win32_PerfFormattedData_PerfOS_System) | Get-Member 
            # | Where-Object { $_.Name -match "context" }`
            $numCtxSwitchLastSec=((Get-CimInstance `
                    Win32_PerfFormattedData_PerfOS_System).ContextSwitchesPersec)

            Write-Output "Context switcher siste sekund: $numCtxSwitchLastSec" 
        }
        5 { 

            # found with `(Get-CimInstance 
            # Win32_PerfFormattedData_Counters_ProcessorInformation) |
            # Get-Member | Where-Object { $_.Name -match "privilege" }`
            $percPrivTime=(((Get-CimInstance Win32_PerfFormattedData_Counters_ProcessorInformation) `
                    | Where-Object { $_.Name -eq "_TOTAL" }).PercentPrivilegedTime)

            # found with `(Get-CimInstance Win32_PerfFormattedData_Counters_ProcessorInformation) 
            # | Get-Member | Where-Object { $_.Name -match "time" }`
            $percUsermode=(((Get-CimInstance `
                    Win32_PerfFormattedData_Counters_ProcessorInformation) | `
                    Where-Object { $_.Name -eq "_TOTAL" }).PercentUserTime)


            Write-Output "Prosent CPU tid i kernel (privileged) / usermode: $percPrivTime / $percUsermode" 
        }
        6 { 

            # found with `(Get-CimInstance Win32_PerfFormattedData_Counters_ProcessorInformation) 
            # | Get-Member | Where-Object { $_.Name -match "inter" }`
            $interruptsLastSec=(((Get-CimInstance `
                    Win32_PerfFormattedData_Counters_ProcessorInformation) `
                    | Where-Object { $_.Name -eq "_TOTAL" }).InterruptsPersec)

            Write-Output "Der var $interruptsLastSec interrupts det siste sekundet" 
        }
        default { 
            Write-Output "$ans er ikke en gyldig kommando" 
        }

    }

    # Read menu choice
    $ans = doMenu
}
