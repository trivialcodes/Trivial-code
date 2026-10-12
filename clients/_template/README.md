# CLIENT FOLDER TEMPLATE (`clients/_template/`)

> Every new client onboarded to Trivial Code receives their own dedicated subdirectory under `/clients/`.  
> Directory naming standard: `/clients/client_<firstname><lastname>/` (all lowercase, no spaces).

---

## Folder Structure
```text
clients/client_<clientname>/
├── README.md               # Client profile, deliverables, dates, passcodes
├── study-guide.html        # Custom standalone study guide (if applicable)
├── assets/                 # Client slide decks, images, diagrams, syllabus
└── database/               # SQL queries used to seed or update this client in Supabase
```

---

## Standard `README.md` Template for Each Client
```markdown
# Client Record: [Client Full Name]

- **Client ID:** [Supabase UUID]
- **Contact:** [Email] | [Phone]
- **Institution / School:** [University / Organization]
- **Course Name:** [e.g. CLST 036 — Greek & Roman Mythology]
- **Active Passcode:** [e.g. CLST036]
- **Creation Date:** [YYYY-MM-DD]
- **Expiration Date:** [YYYY-MM-DD]
- **Status:** Active / In Review / Expired / Revoked

### Deliverables Checklist
- [ ] Raw syllabus & notes ingested
- [ ] Custom study guide HTML assembled with Dark Luxury theme
- [ ] Supabase record created & heartbeat concurrency enabled
- [ ] Passcode route linked in study.html
- [ ] Quality assurance tested on mobile (320px) and desktop
- [ ] Pushed to GitHub main branch
```
