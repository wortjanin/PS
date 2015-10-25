Function GetFreeDiskSpace([string]$DriveLetter, [string]$Measurement)
{

  $Drives=Get-WmiObject -Class Win32_LogicalDisk

  foreach($Drive in $Drives)
  {

    If ($Drive.Name -eq $DriveLetter) 
    {
        return $Drive.FreeSpace/“1$Measurement“
    }

  }

}


$C_space = GetFreeDiskSpace “C:” 

$D_space = GetFreeDiskSpace “D:” 

$rnd = Get-Random

write-host “Freespace for disk C: = $C_space, and for D: = $D_space” 


write-host "$rnd"



$invocation = (Get-Variable MyInvocation).Value
$directorypath = Split-Path $invocation.MyCommand.Path

$filepath = $directorypath + '\files\test.bin0'

[int] $numToCopy = $($C_space / (Get-Item $filepath).length)

write-host "$numToCopy files to copy"


# del $($directorypath + '\fileCopies\*')


$curDate = $( get-date -uformat "%Y%m%d%H%M%S")

if((Test-Path $($directorypath + '\fileCopies\')) -eq 0)
{
   mkdir $($directorypath + '\fileCopies\');
}


$nFiles = 32
$nToCopy = $numToCopy
for( $j=0; $j -lt $nToCopy; $j++) {

    [int] $mod = (Get-Random) % $nFiles

    $filepath = $directorypath + '\files\test.bin' + $mod

    $copyPath = $directorypath + '\fileCopies\copy_' + $curDate + '_' + $j

    copy $filepath $copyPath 

    if($j % 1000 -eq 0){
    	write-host "$j files copied out of $nToCopy"
    }
}