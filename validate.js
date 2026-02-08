#!/usr/bin/env node
"use strict";

/**
 * validate.js — lightweight structural checks for the Phoenix SharePoint theme.
 *
 * Verifies that:
 *  1. Required project files exist
 *  2. index.html contains essential HTML structure
 *  3. The PowerShell script defines all three expected themes
 *  4. Brand colour values are consistent between HTML and PS1
 */

const fs = require("fs");
const path = require("path");

const ROOT = __dirname;
let failures = 0;

function pass(msg) {
  console.log(`  \x1b[32m✓\x1b[0m ${msg}`);
}

function fail(msg) {
  console.error(`  \x1b[31m✗\x1b[0m ${msg}`);
  failures++;
}

function check(condition, msg) {
  condition ? pass(msg) : fail(msg);
}

// ── 1. Required files ────────────────────────────────────────────────────────
console.log("\n1. Required files");

const requiredFiles = [
  "index.html",
  "Phoenix-SharePoint-Theme.ps1",
  "assets/Phoenix_Transparent.png",
  "assets/Phoenix_Black_Background.jpg",
  "README.md",
];

for (const file of requiredFiles) {
  check(fs.existsSync(path.join(ROOT, file)), `${file} exists`);
}

// ── 2. HTML structure ────────────────────────────────────────────────────────
console.log("\n2. HTML structure");

const html = fs.readFileSync(path.join(ROOT, "index.html"), "utf8");

check(html.includes("<!DOCTYPE html>"), "Has DOCTYPE");
check(html.includes('<html lang="en">'), "Has html lang attribute");
check(html.includes("<meta charset"), "Has charset meta");
check(html.includes('name="viewport"'), "Has viewport meta");
check(html.includes("</header>"), "Has header element");
check(html.includes("</main>"), "Has main element");
check(html.includes("</footer>"), "Has footer element");
check(html.includes("PHOENIX"), "Contains Phoenix branding");

// ── 3. Brand colours in HTML ─────────────────────────────────────────────────
console.log("\n3. Brand colours in HTML");

check(html.includes("#FF1A1A"), "Phoenix Red (#FF1A1A) present");
check(html.includes("#D4AF37"), "Phoenix Gold (#D4AF37) present");
check(html.includes("#0a0a0a"), "Deep Black (#0a0a0a) present");

// ── 4. PowerShell theme definitions ──────────────────────────────────────────
console.log("\n4. PowerShell theme definitions");

const ps1 = fs.readFileSync(path.join(ROOT, "Phoenix-SharePoint-Theme.ps1"), "utf8");

check(ps1.includes("PhoenixElectric-Dark"), "Dark theme defined");
check(ps1.includes("PhoenixElectric-Gold"), "Gold theme defined");
check(ps1.includes("PhoenixElectric-Light"), "Light theme defined");
check(ps1.includes("#FF1A1A"), "PS1 uses Phoenix Red");
check(ps1.includes("#D4AF37"), "PS1 uses Phoenix Gold");

// ── Summary ──────────────────────────────────────────────────────────────────
console.log("");
if (failures === 0) {
  console.log(`\x1b[32mAll checks passed.\x1b[0m\n`);
} else {
  console.error(`\x1b[31m${failures} check(s) failed.\x1b[0m\n`);
  process.exit(1);
}
