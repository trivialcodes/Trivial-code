# Client Record: Brandon Thomas

- **Client Name:** Brandon Thomas
- **Course Name:** CLST 036 — Greek & Roman Mythology
- **Active Passcode:** `CLST036`
- **Creation Date:** 2026-10-11
- **Duration:** 5 Months
- **Expiration Date:** `2027-03-11T23:59:59`
- **Status:** Active
- **Direct Portal Route:** `study.html` &rarr; Enter `CLST036` &rarr; `study-clst036.html?unlocked=1`
- **Local File Location:** `clients/Brandon_Thomas/greek-mythology-study-guide.html`

---

### How to Change Passcode or Expiration:
1. **In the Code:** Open `clients/Brandon_Thomas/greek-mythology-study-guide.html` and scroll to lines ~1390:
   - Change `const VALID_PASSCODE = "YOURNEWCODE";`
   - Change `const EXPIRATION_DATE = new Date("YYYY-MM-DD");`
2. **In Supabase:**
   ```sql
   UPDATE public.study_guides 
   SET expires_at = '2027-03-11 23:59:59+00', passcode = 'CLST036' 
   WHERE client_id = (SELECT id FROM public.clients WHERE name = 'Brandon Thomas');
   ```
