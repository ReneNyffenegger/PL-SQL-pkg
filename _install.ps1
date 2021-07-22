sqlplus /nolog `@_install | foreach-object {
   $line = $_
#  $line = $_ -replace '^(error|warning).*|^SP2-.*', "$([char]27)[38;5;9m$line$([char]27)[0m"
   $line = $_ -replace '^(error|warning).*'        , "$([char]27)[38;5;9m$line$([char]27)[0m"
   $line
}
