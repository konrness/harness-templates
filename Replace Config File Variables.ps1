$pathPattern = "${pathPattern}"

$tokenList = @{
  db_user = '${serviceVariable.dbuser}'
  db_password = '${serviceVariable.dbpassword}'
}

Write-Host "= Path Pattern: $pathPattern ="
$files = Get-ChildItem $pathPattern

foreach ($file in $files) {
  $contents = Get-Content -Path $file -RAW

  Write-Host "== $file Original =="
  Write-Host $contents
  
  foreach ( $token in $tokenList.GetEnumerator())
  {
    $pattern = '\#{{{0}}}' -f $token.key
    Write-Host "Replace Pattern: $pattern"
    Write-Host "Replace Value: " $token.value
    $contents = $contents -replace $pattern, $token.value
  }
  Set-Content -Path $file -Value $contents
  
  Write-Host "== $file Modified =="
  Write-Host $contents
}
