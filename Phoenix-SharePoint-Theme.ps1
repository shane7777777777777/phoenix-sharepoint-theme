# Phoenix-SharePoint-Theme.ps1
# Apply Phoenix Electric branding to SharePoint Online
# Created: December 14, 2025
# Updated: February 6, 2026 - Corrected to actual Phoenix colors (Red/Gold/Black)
# Author: Claude for Phoenix Electric

<#
.SYNOPSIS
    Applies Phoenix Electric custom theme to SharePoint Online

.DESCRIPTION
    This script connects to SharePoint Online admin center and applies
    the Phoenix Electric brand colors (Red #FF1A1A, Gold #D4AF37, Black #0a0a0a)
    to the tenant theme gallery. It can then apply the theme to specific sites.

.PARAMETER AdminUrl
    SharePoint Online admin URL (e.g., https://netorgft8573518-admin.sharepoint.com)

.PARAMETER SiteUrl
    Optional. Specific site URL to apply theme to.

.EXAMPLE
    .\Phoenix-SharePoint-Theme.ps1 -AdminUrl "https://netorgft8573518-admin.sharepoint.com"

.EXAMPLE
    .\Phoenix-SharePoint-Theme.ps1 -AdminUrl "https://netorgft8573518-admin.sharepoint.com" -SiteUrl "https://netorgft8573518.sharepoint.com/sites/PhoenixOps"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$AdminUrl,

    [Parameter(Mandatory=$false)]
    [string]$SiteUrl
)

# Check for SharePoint Online Management Shell
if (-not (Get-Module -ListAvailable -Name Microsoft.Online.SharePoint.PowerShell)) {
    Write-Host "Installing SharePoint Online Management Shell..." -ForegroundColor Yellow
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force -AllowClobber
}

Import-Module Microsoft.Online.SharePoint.PowerShell

# Connect to SharePoint Online Admin
Write-Host "Connecting to SharePoint Online Admin..." -ForegroundColor Cyan
try {
    Connect-SPOService -Url $AdminUrl
    Write-Host "Connected successfully!" -ForegroundColor Green
}
catch {
    Write-Host "Failed to connect: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# =============================================================================
# PHOENIX ELECTRIC THEME - DARK MODE (Primary)
# Colors: Phoenix Red #FF1A1A, Phoenix Gold #D4AF37, Deep Black #0a0a0a
# =============================================================================
$PhoenixDarkTheme = @{
    # Theme colors (Red/Gold family)
    "themePrimary" = "#FF1A1A"           # Phoenix Red - main brand color
    "themeLighterAlt" = "#0d0101"        # Almost black with red tint
    "themeLighter" = "#330505"           # Very dark red
    "themeLight" = "#5f0a0a"             # Dark red
    "themeTertiary" = "#bf1414"          # Medium red
    "themeSecondary" = "#e61717"         # Secondary red
    "themeDarkAlt" = "#ff3333"           # Lighter red for hover
    "themeDark" = "#ff5c5c"              # Light red for active states
    "themeDarker" = "#ff8585"            # Lightest red

    # Neutral colors (Dark mode - inverted)
    "neutralLighterAlt" = "#0a0a0a"      # Deep black - page background
    "neutralLighter" = "#151515"         # Slightly lighter black
    "neutralLight" = "#1f1f1f"           # Dark gray
    "neutralQuaternaryAlt" = "#2a2a2a"   # Card backgrounds
    "neutralQuaternary" = "#333333"      # Borders
    "neutralTertiaryAlt" = "#404040"     # Secondary borders
    "neutralTertiary" = "#c8c8c8"        # Placeholder text
    "neutralSecondary" = "#d4d4d4"       # Secondary text
    "neutralPrimaryAlt" = "#e0e0e0"      # Primary text alternate
    "neutralPrimary" = "#ffffff"         # Primary text - white
    "neutralDark" = "#f4f4f4"            # Light text

    # Black and White (inverted for dark theme)
    "black" = "#ffffff"                  # Text color
    "white" = "#0a0a0a"                  # Background color

    # Accent colors
    "accent" = "#D4AF37"                 # Phoenix Gold for highlights
}

# =============================================================================
# PHOENIX ELECTRIC THEME - GOLD ACCENT (For Finance/Accounting pages)
# =============================================================================
$PhoenixGoldTheme = @{
    "themePrimary" = "#D4AF37"           # Phoenix Gold - main
    "themeLighterAlt" = "#0d0b03"        # Almost black with gold tint
    "themeLighter" = "#352c0e"           # Very dark gold
    "themeLight" = "#62521a"             # Dark gold
    "themeTertiary" = "#c4a433"          # Medium gold
    "themeSecondary" = "#debb3d"         # Secondary gold
    "themeDarkAlt" = "#d9b849"           # Lighter gold for hover
    "themeDark" = "#e0c466"              # Light gold for active states
    "themeDarker" = "#e8d28d"            # Lightest gold

    # Same neutral/dark backgrounds
    "neutralLighterAlt" = "#0a0a0a"
    "neutralLighter" = "#151515"
    "neutralLight" = "#1f1f1f"
    "neutralQuaternaryAlt" = "#2a2a2a"
    "neutralQuaternary" = "#333333"
    "neutralTertiaryAlt" = "#404040"
    "neutralTertiary" = "#c8c8c8"
    "neutralSecondary" = "#d4d4d4"
    "neutralPrimaryAlt" = "#e0e0e0"
    "neutralPrimary" = "#ffffff"
    "neutralDark" = "#f4f4f4"
    "black" = "#ffffff"
    "white" = "#0a0a0a"
    "accent" = "#FF1A1A"                 # Red accent on gold theme
}

# =============================================================================
# PHOENIX ELECTRIC THEME - LIGHT MODE (For certain inner pages)
# =============================================================================
$PhoenixLightTheme = @{
    "themePrimary" = "#FF1A1A"           # Phoenix Red
    "themeLighterAlt" = "#fff5f5"        # Lightest red tint
    "themeLighter" = "#ffd6d6"           # Very light red
    "themeLight" = "#ffb3b3"             # Light red
    "themeTertiary" = "#ff6666"          # Medium-light red
    "themeSecondary" = "#ff2e2e"         # Secondary red
    "themeDarkAlt" = "#e61717"           # Darker red for hover
    "themeDark" = "#c21414"              # Dark red for active
    "themeDarker" = "#8f0f0f"            # Darkest red

    # Standard light neutrals
    "neutralLighterAlt" = "#faf9f8"      # Page background
    "neutralLighter" = "#f3f2f1"         # Light gray background
    "neutralLight" = "#edebe9"           # Borders, dividers
    "neutralQuaternaryAlt" = "#e1dfdd"   # Subtle borders
    "neutralQuaternary" = "#d0d0d0"      # Disabled states
    "neutralTertiaryAlt" = "#c8c6c4"     # Secondary borders
    "neutralTertiary" = "#a19f9d"        # Placeholder text
    "neutralSecondary" = "#605e5c"       # Secondary text
    "neutralPrimaryAlt" = "#3b3a39"      # Primary text alternate
    "neutralPrimary" = "#323130"         # Primary text
    "neutralDark" = "#201f1e"            # Dark text
    "black" = "#000000"
    "white" = "#ffffff"
    "accent" = "#D4AF37"                 # Gold accent
}

# Add themes to tenant
Write-Host "`nAdding Phoenix Electric themes to tenant..." -ForegroundColor Cyan

# Dark Theme (Primary)
try {
    Add-SPOTheme -Identity "PhoenixElectric-Dark" -Palette $PhoenixDarkTheme -IsInverted $true -Overwrite
    Write-Host "  [OK] Theme 'PhoenixElectric-Dark' added successfully!" -ForegroundColor Green
}
catch {
    Write-Host "  [FAIL] PhoenixElectric-Dark: $($_.Exception.Message)" -ForegroundColor Red
}

# Gold Theme (Finance)
try {
    Add-SPOTheme -Identity "PhoenixElectric-Gold" -Palette $PhoenixGoldTheme -IsInverted $true -Overwrite
    Write-Host "  [OK] Theme 'PhoenixElectric-Gold' added successfully!" -ForegroundColor Green
}
catch {
    Write-Host "  [FAIL] PhoenixElectric-Gold: $($_.Exception.Message)" -ForegroundColor Red
}

# Light Theme
try {
    Add-SPOTheme -Identity "PhoenixElectric-Light" -Palette $PhoenixLightTheme -IsInverted $false -Overwrite
    Write-Host "  [OK] Theme 'PhoenixElectric-Light' added successfully!" -ForegroundColor Green
}
catch {
    Write-Host "  [FAIL] PhoenixElectric-Light: $($_.Exception.Message)" -ForegroundColor Red
}

# Apply to specific site if provided
if ($SiteUrl) {
    Write-Host "`nApplying dark theme to site: $SiteUrl" -ForegroundColor Cyan
    try {
        Set-SPOWebTheme -Theme "PhoenixElectric-Dark" -Web $SiteUrl
        Write-Host "Theme applied to $SiteUrl successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to apply theme to site: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# List available themes
Write-Host "`nAvailable Phoenix themes in tenant:" -ForegroundColor Cyan
Get-SPOTheme | Where-Object { $_.Name -like "Phoenix*" } | ForEach-Object {
    Write-Host "  - $($_.Name)" -ForegroundColor Yellow
}

# Disconnect
Disconnect-SPOService
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Done! Phoenix themes are now available." -ForegroundColor Green
Write-Host "Go to Site Settings > Change the Look" -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Cyan
