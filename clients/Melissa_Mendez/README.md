# Client Record: Melissa Mendez

- **Client Name:** Melissa Mendez
- **Course Name:** CS 101 — Introduction to Python
- **Active Passcode:** `PYTHON2026`
- **Creation Date:** 2026-10-11
- **Duration:** 2 Days (48 Hours)
- **Expiration Date:** `2026-10-13T23:59:59`
- **Status:** Active
- **Direct Portal Route:** `study.html` &rarr; Enter `PYTHON2026` &rarr; `study-python.html?unlocked=1`
- **Local File Location:** `clients/Melissa_Mendez/python-study-guide.html`

---

### How to Change Passcode or Expiration:
1. **In the Code:** Open `clients/Melissa_Mendez/python-study-guide.html` and search for `PYTHON_EXP_DATE`:
   - Change `const PYTHON_EXP_DATE = new Date("YYYY-MM-DD");`
   - Change `code !== 'PYTHON2026'` to your new passcode.
2. **In Supabase:**
   ```sql
   UPDATE public.study_guides 
   SET expires_at = '2026-10-13 23:59:59+00', passcode = 'PYTHON2026' 
   WHERE client_id = (SELECT id FROM public.clients WHERE name = 'Melissa Mendez');
   ```
