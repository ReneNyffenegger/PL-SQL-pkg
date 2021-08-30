if (-not (($env:SQLPATH -split ';').contains("$pwd\sql_stmt")) ) {
 #
 # Add sql_stmt directory to SQLPATH if not done so already
 #
   $env:SQLPATH="$pwd\sql_stmt;$env:SQLPATH" 
}

sqlplus /nolog `@_install | foreach-object {
   $line = $_
#  $line = $_ -replace '^(error|warning).*|^SP2-.*', "$([char]27)[38;5;9m$line$([char]27)[0m"
   $line = $_ -replace '^(error|warning).*'        , "$([char]27)[38;5;9m$line$([char]27)[0m"
   $line
}
