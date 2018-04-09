# Takes a set of process-ID'S as command line arguments and writes to a file 
# "PID_dato.meminfo" the following info:
# * Total use of virtual memory (VirtualMemorySize)
# * Size of working set

foreach ($id in $args) {
    
    # holds contents to eventually be written to file 
    $contents=""

    # fetch info to be printed to file
    # I'M PRESUMING that the command returns a size in bytes
    $contents+="*********** Minne info om prosess med PID $id ***********"
    $contents+="`n"
    $contents+="Virtual Memory Size: $($(Get-Process -Id $id).VM) byte(s)"
    $contents+="`n"
    $contents+="Working Set Size: $($(Get-Process -Id $id).WS) byte(s)"

    # build filename
    $filename="$($id)_$(Get-Date -format 'yyyyMMdd').meminfo"

    # write contents to file
    $contents | Out-File $filename
}
