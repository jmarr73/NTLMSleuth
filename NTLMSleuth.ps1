 param(
    [Alias("i")]
    [string]$InputFilePath,

    [Alias("o")]
    [string]$OutputFilePath,

    [Alias("h")]
    [switch]$Help
)

function Invoke-WebRequestForEachLine {
    param(
        [string]$InputFilePath,
        [string]$OutputFilePath
    )

    $hashes = Get-Content -Path $InputFilePath
    $uniqueHashes = $hashes | Sort-Object -Unique
    $results = @()
    $foundCount = 0

    foreach ($hash in $uniqueHashes) {
        try {
            $response = (Invoke-WebRequest -Uri "https://ntlm.pw/$hash").Content
            if (-not [string]::IsNullOrWhiteSpace($response)) {
                $resultString = "${hash}: $response"
                Write-Host $resultString -ForegroundColor Green
                $results += $resultString
                $foundCount++
            } else {
                Write-Host "${hash}: No result found" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "${hash}: Error processing" -ForegroundColor Red
        }
    }

    # Output to file if specified
    if ($OutputFilePath) {
        $results | Out-File -FilePath $OutputFilePath
    }

    # Display statistics
    $totalCount = $hashes.Count
    $uniqueCount = $uniqueHashes.Count
    $percentFound = ($foundCount / $uniqueCount) * 100

    $stats = @"
    Total Hashes: $totalCount
    Unique Hashes: $uniqueCount
    Hashes With Results: $foundCount
    Percentage Found (Unique): $($percentFound.ToString("F2"))%
"@

    Write-Host -ForegroundColor Green $stats

    # If output file specified, append statistics
    if ($OutputFilePath) {
        $stats | Out-File -FilePath $OutputFilePath -Append
    }
}

function Show-Help {
    Write-Host "Usage of NTLMSleuth PowerShell Script"
    Write-Host "---------------------------"
    Write-Host "This script reads each line from a specified input file and performs a web request for each line."
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "-i or -InputFilePath   Specifies the path of the input file."
    Write-Host "-o or -OutputFilePath  Specifies the path of the output file to save the results (optional)."
    Write-Host "-h or -Help            Displays this help message."
    Write-Host ""
    Write-Host "Example:"
    Write-Host ".\NTLMSleuth.ps1 -i 'C:\path\to\input.txt' -o 'C:\path\to\output.txt'"
    Write-Host "This example reads lines from 'input.txt' and saves the results to 'output.txt'."
}

# Handle Help parameter
if ($Help) {
    Show-Help
    return
}

# Check if the InputFilePath parameter is provided
if ([string]::IsNullOrWhiteSpace($InputFilePath)) {
    Write-Host "Error: Input file path is required. Use -i or -InputFilePath to specify it. See additional information via -h or -Help." -ForegroundColor Red
    return
}

# Main function invocation
Invoke-WebRequestForEachLine -InputFilePath $InputFilePath -OutputFilePath $OutputFilePath 

