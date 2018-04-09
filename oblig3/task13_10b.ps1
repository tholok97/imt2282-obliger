# Prints number of threads per chrome-process

# Shortened form:
ps chrome | % { echo "chrome $($_.Id) $($_.Threads.Count)" }

# Long form:
# Get-Process chrome | ForEach-Object { Write-Host "chrome $($_.Id) $($_.Threads.Count)" }
