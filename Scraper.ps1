$h = @(
    "https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-https.txt",
    "https://raw.githubusercontent.com/jetkai/proxy-list/main/online-proxies/txt/proxies-http.txt",
    "https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all"
)

$s4 = @(
    "https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks4&timeout=10000&country=all"
)

$s5 = @(
    "https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks5&timeout=10000&country=all"
)

## i might add more urls i was just lazy lol
$fH = 'http.txt'
$fS4 = 'socks4.txt'
$fS5 = 'socks5.txt'

function Invoke-Scrape {
    param([string]$u)
    try {
        (Invoke-WebRequest -Uri $u).Content
    }
    catch {
        return $null
    }
}

function Save-ScrapedFile {
    param([string]$f, [string]$u)
    try {
        Invoke-Scrape $u | Set-Content -Path $f -Force
    }
    catch {
    }
}

Clear-Host
$Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size (120, 30)

$b = @"
______                              _______                                   
|   __ \.----.-----.--.--.--.--.    |     __|.----.----.---.-.-----.-----.----.
|    __/|   _|  _  |_   _|  |  |    |__     ||  __|   _|  _  |  _  |  -__|   _|
|___|   |__| |_____|__.__|___  |    |_______||____|__| |___._|   __|_____|__|  
                         |_____|                             |__|              

Made by @evilbytecode                                   
"@
Write-Host $b -ForegroundColor Magenta

$host.ui.RawUI.WindowTitle = "Windkitty Proxy Scraper - Made By: @evilbytecode"

Write-Host "[+] This program will autoscrape proxies into separate files" -ForegroundColor Yellow
Write-Host "[+] Scraping Proxies Please Wait . . ." -ForegroundColor Magenta
Write-Host ""

foreach ($hu in $h) { Save-ScrapedFile -f $fH -u $hu }

Write-Host "[!] Successfully Scraped And Saved HTTP Proxies!" -ForegroundColor Red
Start-Sleep -Seconds 1

foreach ($s4u in $s4) { Save-ScrapedFile -f $fS4 -u $s4u }

Write-Host "[!] Successfully Scraped And Saved SOCKS4 Proxies!" -ForegroundColor Red
Start-Sleep -Seconds 1

foreach ($s5u in $s5) { Save-ScrapedFile -f $fS5 -u $s5u }

Write-Host "[!] Successfully Scraped And Saved SOCKS5 Proxies!" -ForegroundColor Red
Start-Sleep -Seconds 1

Start-Sleep -Seconds 1
Write-Host "Thanks for using my tools <3" -ForegroundColor Yellow
Write-Host "Press any key to continue . . ." -ForegroundColor Red
$null = $host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
