# TRIVIAL CODE — MANUAL OPERATIONS GUIDE (NO-AI CONTINGENCY)

> **Document Type:** Operational Manual & Contingency Protocol  
> **Audience:** Production Team (Internal Operations)  
> **Purpose:** Step-by-step instructions for adding clients, generating passcodes, configuring expiration dates, setting up study modules, managing sessions, and backing up code manually to Supabase and GitHub without AI assistance.

---

## 1. Quick Reference & System Topology

| Resource | Value / Location |
| :--- | :--- |
| **Supabase Project ID** | `fumwppanjyrccbtoxdli` (us-east-1) |
| **Supabase Dashboard** | [https://supabase.com/dashboard/project/fumwppanjyrccbtoxdli](https://supabase.com/dashboard/project/fumwppanjyrccbtoxdli) |
| **SQL Editor** | [https://supabase.com/dashboard/project/fumwppanjyrccbtoxdli/sql/new](https://supabase.com/dashboard/project/fumwppanjyrccbtoxdli/sql/new) |
| **Table Editor** | [https://supabase.com/dashboard/project/fumwppanjyrccbtoxdli/editor](https://supabase.com/dashboard/project/fumwppanjyrccbtoxdli/editor) |
| **GitHub Repository** | `https://github.com/trivialcodes/Trivial-code` |
| **Local Live Server** | `http://localhost:3000/study.html` |
| **Primary Frontend Files** | `study.html` (Gatekeeper portal), `study-python.html` (Study Guide) |

---

## 2. Managing Clients & Study Guides in Supabase

Every study guide access pass requires two primary records:
1. An entry in **`public.clients`** (holds client identity/contact information).
2. An entry in **`public.study_guides`** (links client ID to access passcode, active duration, and max concurrent devices).

---

### Step 2.1: Add a Client & Create a Passcode (Combined SQL)

Navigate to **Supabase Dashboard → SQL Editor → New Query**, paste the script below, edit the parameters, and click **Run**.

```sql
DO $$
DECLARE
  new_client_id UUID;
  new_guide_id UUID;
BEGIN
  -- 1. Insert Client Record
  INSERT INTO public.clients (full_name, email, school_name, created_at)
  VALUES ('Jane Doe', 'jane.doe@university.edu', 'University of Florida', NOW())
  RETURNING id INTO new_client_id;

  -- 2. Insert Study Guide Record with Passcode and Expiration
  -- Note: Passcode is automatically uppercased
  INSERT INTO public.study_guides (
    client_id,
    course_name,
    passcode,
    status,
    expires_at,
    max_devices,
    created_at
  )
  VALUES (
    new_client_id,
    'Introduction to Python Programming',
    UPPER('PYTHON2026'),            -- Replace with unique client passcode
    'active',                       -- 'active', 'revoked', or 'expired'
    NOW() + INTERVAL '14 days',     -- Set expiration (e.g., '14 days', '48 hours', '30 days')
    1,                              -- 1 concurrent session enforced
    NOW()
  )
  RETURNING id INTO new_guide_id;

  RAISE NOTICE 'Client ID: % | Guide ID: %', new_client_id, new_guide_id;
END $$;
```

---

### Step 2.2: Add Study Guide Modules & Flashcards (Optional Database Content)

If storing study modules and flashcard data directly inside Supabase:

```sql
-- Replace <GUIDE_UUID> with the guide id returned from Step 2.1
INSERT INTO public.study_modules (guide_id, title, sort_order, content)
VALUES (
  'PASTE-GUIDE-UUID-HERE',
  'Module 1: Variables & Control Flow',
  1,
  '{
    "summary": "Core concepts covering dynamic typing, conditional branching, and loops.",
    "cards": [
      {"q": "What is an immutable data type in Python?", "a": "Tuples, integers, floats, strings, and frozensets."},
      {"q": "What is the difference between is and ==?", "a": "== checks value equality; is checks memory identity."}
    ]
  }'::jsonb
);
```

---

### Step 2.3: Modify Expiration Dates, Status, or Passcodes

#### Extend an Expiration Date:
```sql
UPDATE public.study_guides
SET expires_at = expires_at + INTERVAL '7 days'
WHERE passcode = 'PYTHON2026';
```

#### Revoke Access Immediately:
```sql
UPDATE public.study_guides
SET status = 'revoked'
WHERE passcode = 'PYTHON2026';
```

#### Change a Passcode:
```sql
UPDATE public.study_guides
SET passcode = UPPER('NEWCODE2026')
WHERE passcode = 'OLDCODE2026';
```

#### Reset Locked Sessions (Clear In-Use Concurrency Locks):
```sql
DELETE FROM public.study_sessions
WHERE guide_id = (SELECT id FROM public.study_guides WHERE passcode = 'PYTHON2026');
```

---

### Step 2.4: Active Dashboard View Query

Run this query anytime to view all active clients, passcodes, expiration dates, and active session counts:

```sql
SELECT 
  c.full_name,
  c.email,
  sg.course_name,
  sg.passcode,
  sg.status,
  sg.expires_at,
  CASE 
    WHEN sg.expires_at < NOW() THEN 'EXPIRED'
    WHEN sg.status = 'revoked' THEN 'REVOKED'
    ELSE 'ACTIVE'
  END AS current_state,
  COUNT(ss.id) AS active_sessions
FROM public.study_guides sg
JOIN public.clients c ON c.id = sg.client_id
LEFT JOIN public.study_sessions ss ON ss.guide_id = sg.id 
  AND ss.last_heartbeat > (NOW() - INTERVAL '45 seconds')
GROUP BY c.full_name, c.email, sg.course_name, sg.passcode, sg.status, sg.expires_at
ORDER BY sg.created_at DESC;
```

---

## 3. Linking a Passcode to a Frontend Guide (`study.html`)

When a client accesses `study.html`, the passcode can either:
1. Route directly to a dedicated HTML file (e.g. `study-python.html` or `study-bio101.html`).
2. Verify against Supabase and load dynamically.

### Adding a Dedicated Guide Route in `study.html`:

1. Open `study.html` in an editor.
2. Locate the `handleUnlock()` function (around lines 330–360).
3. Add a routing branch:

```javascript
// Hardcoded dedicated guide routing
if (cleanCode === 'PYTHON2026') {
    showToast('Passcode verified. Opening Python Study Guide...', 'success');
    setTimeout(() => {
        window.location.href = 'study-python.html?unlocked=1';
    }, 600);
    return;
}

if (cleanCode === 'BIO2026') {
    showToast('Passcode verified. Opening Biology Study Guide...', 'success');
    setTimeout(() => {
        window.location.href = 'study-biology.html?unlocked=1';
    }, 600);
    return;
}
```

> **Note on `?unlocked=1`:** Always include the `?unlocked=1` URL query parameter so the destination page bypasses any initial lock overlay and displays immediately.

---

## 4. Manual Git & GitHub Workflow

Whenever code, study guides, or documentation are modified locally, push updates using the terminal:

### Step 4.1: Check Status
```bash
cd "/Users/brandonthomas/final trivial code project"
git status
```

### Step 4.2: Stage & Commit
```bash
git add .
git commit -m "Update: add client study guide and adjust access policies"
```

### Step 4.3: Push to GitHub
```bash
git push origin main
```

---

## 5. Security & Anti-Leaking Protections Summary

The platform employs a multi-tiered security system to deter sharing and piracy:

1. **Concurrency Heartbeat (`concurrency_heartbeat.sql`):**  
   Enforces a strict 1-device active limit per guide. If a second user enters the passcode while someone is actively studying, access is rejected with `IN_USE` until the active device closes the tab or remains inactive for 45 seconds.
2. **Dynamic Watermarking:**  
   Diagonal translucent watermarks displaying session hashes, timestamps, and origin metadata sit above content.
3. **Blur Shield:**  
   Focus/visibility events blur study guide contents when the browser window loses focus (e.g. during snippet or capture attempts).
4. **Keystroke Interception:**  
   Common screenshot key combinations (`Cmd+Shift+3`, `Cmd+Shift+4`, `PrintScreen`) are prevented at the DOM listener level.

---

## 6. Emergency Troubleshooting Checklist

| Symptom | Probable Cause | Immediate Resolution |
| :--- | :--- | :--- |
| **Passcode button does nothing** | Identifier clash or JS error | Ensure Supabase client is initialized as `_supabaseClient = supabase.createClient(...)` and not `let supabase`. |
| **Guide reports "Device Limit Reached"** | Orphaned active session | Run the session cleanup SQL in Step 2.3 to clear stale session tokens. |
| **Passcode displays "Expired"** | Expiration timestamp has passed | Extend `expires_at` using SQL in Step 2.3. |
| **Page re-locks immediately on refresh** | Missing query parameter | Ensure link ends with `?unlocked=1`. |
