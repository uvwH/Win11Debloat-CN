<#
    .SYNOPSIS
        Returns preset names and application IDs from Apps.json, or an empty array when unavailable.
#>
function Import-AppPresetsFromJson {
    try {
        $jsonContent = Get-Content -Path $script:AppsListFilePath -Raw | ConvertFrom-Json
    }
    catch {
        Write-Warning "读取 Apps.json 失败：$_"
        return @()
    }

    if (-not $jsonContent.Presets) {
        return @()
    }

    # Apply per-language preset name overrides when available
    $presetOverrides = $null
    if ($script:Lang -and $script:Lang.AppDetails -and $script:Lang.AppDetails.Presets) {
        $presetOverrides = $script:Lang.AppDetails.Presets
    }

    return @($jsonContent.Presets | ForEach-Object {
        $presetName = $_.Name
        if ($presetOverrides -and $presetOverrides.PSObject.Properties[$presetName]) {
            $presetName = [string]$presetOverrides.PSObject.Properties[$presetName].Value
        }

        [PSCustomObject]@{
            Name   = $presetName
            AppIds = @($_.AppIds)
        }
    })
}
