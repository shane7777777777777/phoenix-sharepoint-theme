# Phoenix SharePoint Theme

Custom SharePoint Online theme and branded homepage for **Phoenix Electric LLC**.

## Overview

This project provides:

- **3 SharePoint Online themes** (Dark, Gold, Light) using Phoenix Electric brand colors
- **Premium branded homepage** (`index.html`) with glass-morphism design and responsive layout

### Brand Colors

| Color         | Hex       | Usage                  |
|---------------|-----------|------------------------|
| Phoenix Red   | `#FF1A1A` | Primary brand color    |
| Phoenix Gold  | `#D4AF37` | Accent & highlights    |
| Deep Black    | `#0a0a0a` | Dark mode background   |

## Project Structure

```
phoenix-sharepoint-theme/
├── index.html                     # Branded SharePoint homepage
├── Phoenix-SharePoint-Theme.ps1   # PowerShell theme deployment script
├── assets/
│   ├── Phoenix_Black_Background.jpg
│   └── Phoenix_Transparent.png
├── package.json
└── README.md
```

## Prerequisites

- **SharePoint Online** tenant with admin access
- **PowerShell 5.1+** with the `Microsoft.Online.SharePoint.PowerShell` module
- A modern web browser (for previewing the homepage)

## Installation

### 1. Install the SharePoint Themes

Run the PowerShell deployment script to register the Phoenix themes in your SharePoint tenant:

```powershell
# Basic — registers all three themes
.\Phoenix-SharePoint-Theme.ps1 -AdminUrl "https://<tenant>-admin.sharepoint.com"

# Apply dark theme to a specific site
.\Phoenix-SharePoint-Theme.ps1 \
  -AdminUrl "https://<tenant>-admin.sharepoint.com" \
  -SiteUrl  "https://<tenant>.sharepoint.com/sites/PhoenixOps"
```

The script registers three theme variants:

| Theme                   | Style | Use Case                    |
|-------------------------|-------|-----------------------------|
| `PhoenixElectric-Dark`  | Dark  | Primary — most pages        |
| `PhoenixElectric-Gold`  | Dark  | Finance / Accounting pages  |
| `PhoenixElectric-Light` | Light | Inner content pages         |

After registration, apply a theme via **Site Settings → Change the Look** in SharePoint.

### 2. Deploy the Homepage

Upload `index.html` and the `assets/` folder to your SharePoint site (e.g., the Site Pages library or Site Assets). Then set `index.html` as the site's home page.

## Development

### Quick Start

```bash
npm install   # install dev dependencies
npm start     # open homepage in default browser
```

### Available Scripts

| Command           | Description                              |
|-------------------|------------------------------------------|
| `npm start`       | Opens `index.html` in the default browser |
| `npm run validate`| Checks HTML structure for issues          |
| `npm test`        | Runs validation checks                   |

## Themes

### Dark Theme (Primary)

Red primary with gold accent on a deep-black background. Designed for the main operational hub.

### Gold Theme (Finance)

Gold primary with red accent. Same dark background, used for finance and accounting sections.

### Light Theme

Red primary with gold accent on a standard light background for inner content pages.

## License

Proprietary — Phoenix Electric LLC © 2026
