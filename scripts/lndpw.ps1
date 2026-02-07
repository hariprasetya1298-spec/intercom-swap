param(
  [Parameter(Mandatory = $true)]
  [string]$OutFile
)

function ToPlain([Security.SecureString]$s) {
  $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($s)
  try { return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr) }
  finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr) }
}

$pw1 = Read-Host "LND wallet password" -AsSecureString
$pw2 = Read-Host "Confirm password" -AsSecureString

$p1 = ToPlain $pw1
$p2 = ToPlain $pw2

if ([string]::IsNullOrEmpty($p1)) {
  Write-Error "Password cannot be empty."
  exit 1
}
if ($p1 -ne $p2) {
  Write-Error "Passwords do not match."
  exit 1
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $OutFile) | Out-Null

# Write without trailing newline.
[System.IO.File]::WriteAllText($OutFile, $p1, [System.Text.Encoding]::UTF8)

Write-Output "Wrote password file: $OutFile"

