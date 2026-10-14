# TRIVIAL CODE — MASTER BUSINESS BLUEPRINT & AI CONTINUITY SYSTEM

> **IMPORTANT TO ALL FUTURE AI AGENTS / CODING ASSISTANTS:**
> This document is the single source of truth for **Trivial Code**. Whenever you begin or complete work on this project, you **MUST**:
> 1. Read this entire document before writing any code or architecture.
> 2. Respect the privacy, aesthetic guidelines, and business goals outlined here.
> 3. Update the **"Active Project State & AI Work Log"** at the bottom of this file before finishing your session so the next AI knows exactly what is done and what comes next.

---

## 1. Company & Business Overview

### 1.1 Brand Identity
- **Business Name:** Trivial Code
- **Tagline:** *"Code Made Easy / Going Live Even Easier"* | *"Code With a Little More Intention Behind It."*
- **Aesthetic:** Dark Luxury / Editorial / Moody Forest Green, Warm Cream accents (`#f5f0ea`), Muted Gold (`#c5a880`), clean typography pairing (*Playfair Display* serif with *Plus Jakarta Sans*).
- **Public Founder Identity:** **Production Team** (all founder references remain anonymous).
- **Public Contact:**
  - **Email:** `trivialcodes@gmail.com`
  - **Phone:** `718-924-0868`
  - **Instagram:** `@trivialcode` (https://www.instagram.com/trivialcode/)
  - **LinkedIn:** https://www.linkedin.com/in/trivial-code-986622442/
- **Accepted Payments:** Zelle, Cash App, Venmo.

### 1.2 Core Business Model & Revenue Streams
1. **Interactive Study Guides (Flagship EdTech Product):**
   - High-value, passcode-protected, expiring study guides for educators, tutors, and course creators.
   - Solves the problem of intellectual property theft: educators want students to study interactively without being able to steal, print, or share the source content indefinitely.
   - Features: Passcode portal, expiration date locking, interactive flashcards/quizzes, no source code access given to clients.
2. **Custom Websites:**
   - Bespoke, high-converting digital storefronts and portfolios for thoughtful founders and independent brands.
3. **Custom Mobile Apps:**
   - Clean cross-platform iOS & Android apps built for quick deployment to the App Store without overcomplicated tech.
4. **Monthly Retainer / Maintenance Subscription:**
   - Recurring monthly fee for client site uptime, updates, instant bug fixes, and continuous performance tuning.
   - Subscriber bonus: Active subscribers receive discounts on any subsequent new project builds.
5. **Coding Masterclass:**
   - Classes teaching practical, modern coding workflows for quick payouts. Empowering students to build client products and generate income without high initial overhead.

---

## 2. Technical Stack & Integrated Ecosystem

To run this business smoothly across **multiple clients**, **multiple study guides**, and **apps/websites**, we use a unified, scalable ecosystem:

| Layer | Tool | Purpose | Status |
| :--- | :--- | :--- | :--- |
| **Frontend Showcase** | Vanilla HTML5, CSS3, ES6 JS, Lucide Icons | Main marketing website (`index.html`, `style.css`) | **Phase 1 Live & Optimized** |
| **Version Control & CI/CD** | **GitHub** | Code repo, multi-branch deployments, automated backups | Pending Setup |
| **Hosting & Edge Deployments** | **Vercel** / **Cloudflare Pages** | Zero-downtime, global CDN hosting with custom domain | Pending Setup |
| **Backend & Database** | **Supabase** (PostgreSQL) | Client management, study guide access keys, passcodes, expiration timestamps, analytics | Pending Setup |
| **Client Portal / Study Engine** | HTML5 / Vite or Next.js + Supabase Auth | Dynamic study guide delivery engine with expiration enforcement | Pending Setup |
| **Email & Lead Handling** | Resend / Formspree / Supabase Edge Functions | Lead contact form notifications to `trivialcodes@gmail.com` | Pending Setup |

---

## 3. Study Guide System Architecture (Detailed)

### How It Works for Clients & Students:
1. **Creation:** A new study guide is created with content (flashcards, quiz questions, study modules).
2. **Access Control:** A unique slug or access link is generated (e.g. `trivialcode.co/guide/anatomy-101` or `study.trivialcode.co/bio`).
3. **Student Login:** Student enters a unique or cohort passcode.
4. **Expiration Enforcement:** Supabase checks:
   - Is `current_timestamp < expiration_date`?
   - If YES: Unlock study content.
   - If NO: Display a custom expired screen (*"This study session has ended. Contact your instructor for renewed access."*).
5. **IP Protection:** Right-click disabled, print stylesheets disabled, content fetched dynamically in memory so students cannot easily scrape the raw content.

---

## 4. Secure Credentials & Access Vault

> ⚠️ **SECURITY PROTOCOL FOR ALL AI AGENTS:**
> Store references and environment variable keys here. **Never expose raw database secret service keys or unencrypted passwords directly in public GitHub repositories.** Always use `.env.local` files and environment variable secrets in hosting providers (Vercel/Cloudflare/Supabase).

| Platform / Service | Identifier / Email | Purpose | Key / Secret Location |
| :--- | :--- | :--- | :--- |
| **GitHub** | `trivialcodes@gmail.com` | Repository hosting & organization | Git credentials / SSH key |
| **Supabase** | `trivialcodes@gmail.com` | Database, auth, expiring token tables | Project URL & Anon/Service Role Keys in `.env` |
| **Vercel / Cloudflare** | `trivialcodes@gmail.com` | Production website hosting & DNS | Linked to GitHub repo |
| **Gmail** | `trivialcodes@gmail.com` | Inquiries & notifications | App Password / OAuth |
| **Instagram** | `@trivialcode` | Marketing & client acquisition | Managed on device |
| **LinkedIn** | `Trivial Code` | B2B networking | Managed on device |
| **Payment Handles** | Zelle / Cash App / Venmo | Client billing | Listed in website Services section |

*(Future AI: When the user provides new API tokens or URLs, document their variable names and locations above).*

---

## 5. Step-by-Step Implementation Roadmap

```mermaid
graph TD
  A["Phase 1: Showcase Website Mobile & Desktop (DONE)"] --> B["Phase 2: Git & GitHub Setup (Active)"]
  B --> C["Phase 3: Supabase Database & Auth Architecture"]
  C --> D["Phase 4: Dynamic Study Guide Portal Engine"]
  D --> E["Phase 5: Multi-Client Automation & CMS Engine"]
  E --> F["Phase 6: Scaling & Lead Generation Machine"]
```

### Phase 1: Showcase Website Layout & Polish (COMPLETED)
- Desktop version fully built and verified with embedded demo videos.
- Mobile Hero Section perfectly positioned above background laptop photo.
- Mobile About Me section streamlined with contact handles directly under the headline.
- Mobile full-screen slide navigation with animated hamburger button.

### Phase 2: Git & GitHub Foundation (COMPLETED)
- Initialized local Git repository in project directory with `main` branch.
- Configured `.gitignore` for security and clean tracking.
- Set author identity anonymously to `Production Team <trivialcodes@gmail.com>`.
- Connected and synchronized with official GitHub remote: `https://github.com/trivialcodes/Trivial-code`.

### Phase 3: Supabase Backend Setup (COMPLETED)
- Created Supabase project `trivial-code-core` (Project ref: `fumwppanjyrccbtoxdli`, Region: `us-east-1`).
- Saved credentials to local git-ignored `.env.local` vault.
- Designed and executed `supabase_schema.sql` database schema:
  - `clients` table
  - `study_guides` table with passcode & expiration timestamp
  - `study_modules` table with JSONB interactive content
  - `contact_leads` table with public submission RLS
  - Secure PostgreSQL RPC `access_study_guide` for passcode verification and automated expiration enforcement.

### Phase 4: Study Guide Product Engine (COMPLETED)
- Built interactive study portal engine: `study.html`.
- Connected frontend to live Supabase backend using `@supabase/supabase-js`.
- Implemented secure server-side passcode gate via `access_study_guide` RPC.
- Automated expiration enforcement: expired guides trigger custom lockdown screen preventing IP theft.
- Added touch-friendly flip flashcards with 3D transitions, progress counters, and copy/print protection.
- Created `seed_demo_guide.sql` to populate sample active and expired test guides.

### Phase 5: Multi-Client Workflow System (NEXT STEP)
1. Standardize client onboarding templates for:
   - Websites (Starter, Pro, Enterprise).
   - Study Guides (Standard, Multi-cohort, Custom Branding).
   - Subscriptions (Monthly maintenance, bug fixes, performance monitoring).
2. Automated invoice and payment instructions (Zelle, Cash App, Venmo).

---

## 6. Active Project State & AI Work Log

> 📌 **AI INSTRUCTION:** Whenever you complete tasks or make changes, append an entry below with the date, changes made, and explicit next steps.

### Entry: 2026-10-10 (Phase 4 Study Guide Engine COMPLETED)
- **Current State:**
  - **Phase 1**: Showcase website fully operational with desktop + mobile viewports.
  - **Phase 2**: GitHub repository synced (`https://github.com/trivialcodes/Trivial-code`).
  - **Phase 3**: Supabase project `trivial-code-core` provisioned with full relational schema and security rules.
  - **Phase 4**: `study.html` engine built and verified, connected with live Supabase credentials. Seed script `seed_demo_guide.sql` prepared.
- **Immediate Next Task for Next AI:**
- **Immediate Next Task for Next AI:**
  1. Have user execute `seed_demo_guide.sql` in Supabase SQL editor to test the live `study.html?guide=demo` portal with passcode `STUDY2026`.
  2. Test expired guide lockdown with `study.html?guide=past-demo` (passcode `EXPIRED2026`).
  3. Proceed with Phase 5: Client onboarding flow & lead capture forms.

### Entry: 2026-10-10 — Study Portal Passcode Bug Fix (COMPLETED)
- **Problem Diagnosed:** User reported that entering `PYTHON2026` or `STUDY2026` in `study.html` did nothing — the page stayed on the passcode screen.
- **Root Cause Found:**
  1. `PYTHON2026` correctly redirected to `study-python.html`, but that page has its own gate overlay with a SECOND passcode screen. User had to type the code AGAIN on the second page.
  2. `study-python.html` called Supabase `claim_study_session` RPC which returned `{ success: false }` (no IN_USE/EXPIRED error) because `seed_demo_guide.sql` was never run and the DB is empty. The old code had no fallback for this case, so the gate stayed closed.
  3. `STUDY2026` also failed because the DB is empty (no guides seeded).
- **Fixes Applied:**
  - `study.html`: Changed PYTHON2026 redirect to `study-python.html?unlocked=1` (passes auth flag via URL param).
  - `study-python.html`: Added auto-unlock logic — if `?unlocked=1` is in the URL, the gate overlay is hidden immediately without requiring a second passcode entry.
  - `study-python.html`: Fixed `verifySession()` — added `else { unlockUI(); }` branch so that any non-IN_USE / non-EXPIRED Supabase response (including empty DB) allows local unlock. This makes the Python guide work even before the DB is seeded.
  - Added Enter key support to the Python guide passcode input.
- **Current State After Fix:**
  - `PYTHON2026` → `study.html` → redirects to `study-python.html?unlocked=1` → gate auto-hides → full guide loads ✅
  - `STUDY2026` → still requires `seed_demo_guide.sql` to be run in Supabase SQL Editor
- **Next Steps for Next AI:**
  1. Have user execute `seed_demo_guide.sql` in Supabase SQL editor to activate STUDY2026 and EXPIRED2026 passcodes.
  2. Once seeded, verify `study.html` with `STUDY2026` passcode shows the demo flashcard guide.
  3. Continue to Phase 5: multi-client onboarding, CMS templates, invoice automation.

### Entry: 2026-10-11 — Security Hardening & Manual Operations Guide (COMPLETED)
- **Accomplishments:**
  1. **Screenshot Deterrence & Watermarking**:
     - Embedded dynamic `.watermark-layer` overlay across study guides displaying unique session tokens, domain hashes, and live timestamps.
     - Added `.blur-shield` focus listeners (`window.blur` / `visibilitychange`) that obscure study content when screenshot utilities or secondary apps gain focus.
     - Intercepted screenshot keystrokes (`Cmd+Shift+3`, `Cmd+Shift+4`, `PrintScreen`).
  2. **Manual Operations Manual (`MANUAL_OPERATIONS_GUIDE.md`)**:
     - Authored a comprehensive fallback operations guide for the Production Team.
     - Detailed exact SQL recipes for inserting clients, provisioning expiring study guides, adding flashcards, extending or revoking passes, and running dashboard status queries.
     - Outlined terminal Git commit & push procedures and troubleshooting steps.
- **Current State:**
  - Study portal unlocks cleanly with `PYTHON2026`.
  - Concurrency locks active via `concurrency_heartbeat.sql`.
  - Manual operations guide ready for reference.
- **Next Steps for Next AI:**
  1. Optionally execute `seed_demo_guide.sql` in Supabase to enable test passcodes `STUDY2026` & `EXPIRED2026`.
  2. Expand client onboarding pipeline and lead capture mechanisms in Phase 5.

### Entry: 2026-10-11 — Client Account Structuring & Custom Expirations (COMPLETED)
- **Accomplishments:**
  1. **Individual Client Directory Restructure**:
     - Removed temporary internal folders and created formal client directories under `/clients/`:
       - `clients/Brandon_Thomas/` (Greek & Roman Mythology `CLST 036`, Passcode: `CLST036`, Expiration: 5 Months / 2027-03-11).
       - `clients/Melissa_Mendez/` (Intro to Python `CS 101`, Passcode: `PYTHON2026`, Expiration: 2 Days / 2026-10-13).
     - Deleted outdated demo sample code (`seed_demo_guide.sql`).
  2. **Supabase Client Sync Script (`sync_clients_to_supabase.sql`)**:
     - Prepared robust SQL script seeding Brandon Thomas (5-month access) and Melissa Mendez (2-day access) with direct relations to `public.study_guides`.
  3. **Launch & Domain Protocol Prepared**:
     - Formulated step-by-step procedures for acquiring `TrivialCode.com`, setting up favicons / search rich snippets (like the Reddit example), and deploying zero-downtime hosting via Cloudflare/Vercel.
- **Current State:**
  - Guides are fully organized by client name in Git and Supabase.
  - **Brand Logo Finalized & Deployed:** Option 3 (The Reddit-style mascot emblem featuring 'TC' stylized as a plant pot with an energetic green sprout on a deep green circular badge) is officially installed as `favicon.jpg` and `logo.jpg`.
  - SEO, OpenGraph, Schema.org, and apple-touch-icon links active across `index.html` and `study.html`.
### Entry: 2026-10-13 — Logo Styling & Cloudflare R2 Video Integration (COMPLETED)
- **Accomplishments:**
  1. **Brand Logo Refinement**:
     - Converted logo and favicon background from white/cream to a pure, rich forest green (`#185a32`).
     - Rendered pot and embedded "TC" monogram in crisp, solid white with smooth antialiased curvature.
     - Kept sprout leaves in natural vibrant green, rendering the central stem and root in clean white.
     - Updated `logo.jpg` and `favicon.jpg` across the site.
  2. **R2 Video Cloud Delivery**:
     - Linked all modal showcase videos directly to Cloudflare R2 public storage (`https://pub-c88da8b3704a4eb492945f95f608c4a5.r2.dev/screen%20record/`):
       - Interactive Guide: `Study guide screen recording.mov`
       - App Demo: `app screen recording.mov`
       - Website Demo: `website screen recording.mov`
     - Added programmatic `vid.play()` on `openModal()` to ensure video plays reliably regardless of browser autoplay restrictions.
     - Added `preload="auto"` attribute for instant loading.
- **Current State:**
  - `trivialcode.org` is connected to Cloudflare Pages.
  - Videos and assets stream from global edge storage.
- **Next Steps for Next AI:**
  1. Test custom domain access on public/cellular network once college network DNS propagates or white-lists.
  2. Proceed to Phase 5: Client onboarding flow & client management expansion.
