$files = Get-ChildItem -Path "c:\vibecoding_work\madkoreanclass" -Filter "*.html"

$scriptTag = '<script type="module" src="assets/js/firebase-init.js"></script>'

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    if ($content -notmatch "firebase-init.js") {
        # Insert before closing body tag
        $content = $content -replace "</body>", "$scriptTag`n</body>"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Injected Firebase script into $($file.Name)"
    }
    else {
        Write-Host "Firebase script already present in $($file.Name)"
    }
}
