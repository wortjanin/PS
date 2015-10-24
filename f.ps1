
[string[]] $strs = @() 

$stringCount = 512
$chunk_size = 512
for( $j=0; $j -lt 3; $j++) {
    [byte[]] $bytes = @()
    for( $i=0; $i -lt $chunk_size; $i++) {
	[int] $mod = (Get-Random) % 255
	if( $mod -eq 0 ) {
	  $mod=95
	}
	$bytes+=@($mod)
    }

    $strs += @([System.Text.Encoding]::ASCII.GetString($bytes))
}

$invocation = (Get-Variable MyInvocation).Value
$directorypath = Split-Path $invocation.MyCommand.Path

$nFiles = 32
for( $j=0; $j -lt $nFiles; $j++) {

    $filepath = $directorypath + '\files\test.bin' + $j

    $nStrings = 1024
    for( $i=0; $i -lt $nStrings; $i++) {
	[byte] $byte = 255
	
	[int] $mod = (Get-Random) % $strs.Count

	out-file -filepath $filepath -inputobject $strs[$mod] -append 

    }
 
    echo "file $($j+1) out of $nFiles"
}