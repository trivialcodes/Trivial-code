# CLIENT ONBOARDING TEMPLATE (`clients/_template/`)

> **Instructions for Production Team:**  
> Whenever onboarding a new client, duplicate this folder and rename it:  
> `/clients/<FirstName>_<LastName>/` (e.g. `/clients/Alex_Rivera/`).

---

## Folder Architecture
```text
clients/<FirstName>_<LastName>/
├── README.md               # Client info, course, passcode, expiration date
├── study-guide.html        # Client study guide code
├── assets/                 # Client slides, syllabus, reference materials
└── database/               # SQL queries to seed client in Supabase
```

---

## 3-Step Client Launch Protocol

### Step 1: Duplicate this folder & fill out README.md
Copy `/clients/_template/` to `/clients/<FirstName>_<LastName>/` and fill out the client metadata below.

### Step 2: Add Passcode Route to `study.html`
Open [study.html](file:///Users/brandonthomas/final%20trivial%20code%20project/study.html) and add the client's uppercase passcode in `handleUnlock()`:
```javascript
// Route for [Client Full Name]
if (passcode === 'PASSCODE') {
  submitBtn.disabled = true;
  submitBtn.innerHTML = `<span>Accessing Study Guide...</span>`;
  window.location.href = 'clients/<FirstName>_<LastName>/study-guide.html?unlocked=1';
  return;
}
```

### Step 3: Run Database Seed in Supabase
Copy the SQL snippet from the bottom of this file into the Supabase SQL Editor and click **Run**.

---

## Standard Client `README.md` Template

```markdown
# Client Record: [Client Full Name]

- **Client ID:** [Supabase UUID]
- **Contact:** [Email] | [Phone]
- **Institution / School:** [e.g. Swarthmore College / NYU]
- **Course Name:** [e.g. CS 101 — Intro to Computer Science]
- **Active Passcode:** [UPPERCASE PASSCODE, e.g. CS101FALL]
- **Creation Date:** [YYYY-MM-DD]
- **Expiration Date:** [YYYY-MM-DD]
- **Status:** Active (In Use)
- **Direct Portal Route:** `study.html` → Enter `[PASSCODE]` → Unlocked Guide

### Deliverables Checklist
- [ ] Raw syllabus & notes audited
- [ ] Custom study guide assembled in Dark Luxury aesthetic
- [ ] Screenshot protection & dynamic watermark verified
- [ ] Supabase record seeded with expiration date
- [ ] Passcode route linked in study.html
- [ ] Tested on mobile (320px) and desktop
- [ ] Committed and pushed to GitHub main branch
```

---

## Supabase Seed SQL Recipe

```sql
DO $$
DECLARE
  v_client_id UUID;
  v_guide_id UUID;
BEGIN
  -- 1. Insert Client Record
  INSERT INTO public.clients (name, email, service_type, subscription_status, notes)
  VALUES (
    'Client Full Name',
    'client.email@domain.com',
    'study_guide',
    'active',
    'Course: Course Name'
  )
  ON CONFLICT (email) DO UPDATE 
    SET name = EXCLUDED.name, service_type = EXCLUDED.service_type
  RETURNING id INTO v_client_id;

  -- 2. Insert Study Guide with Passcode & Expiration
  INSERT INTO public.study_guides (
    client_id,
    title,
    slug,
    passcode,
    expires_at,
    is_active,
    description
  )
  VALUES (
    v_client_id,
    'Course Name Here',
    'unique-course-slug',
    UPPER('CLIENTPASSCODE'),
    NOW() + INTERVAL '30 days', -- Set custom expiration (e.g., '2 days', '5 months', '90 days')
    TRUE,
    'Client interactive study guide'
  )
  ON CONFLICT (slug) DO UPDATE 
    SET passcode = EXCLUDED.passcode,
        expires_at = EXCLUDED.expires_at,
        is_active = TRUE
  RETURNING id INTO v_guide_id;

  RAISE NOTICE 'SUCCESS: Client ID: % | Guide ID: %', v_client_id, v_guide_id;
END $$;
```
