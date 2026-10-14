# TRIVIAL CODE — AI WORKSPACE RULES & CONTINUITY GUIDE

## CRITICAL DIRECTIVE FOR ALL AI AGENTS & MODELS WORKING ON THIS REPOSITORY:

1. **SINGLE SOURCE OF TRUTH**:
   - Before taking ANY action, read `BUSINESS_PLAN_AND_AI_SYSTEM.md`.
   - It contains the complete brand identity, business architecture, credentials vault, tech stack, and roadmap.

2. **ANONYMITY RULE**:
   - The founder must ALWAYS remain anonymous publicly.
   - Use **"Production Team"** for all signatures and public attributions. Do NOT put individual founder names on the site.

3. **MULTI-AI ASSEMBLY LINE RECOGNITION**:
   - Review `MULTI_AI_PRODUCTION_SYSTEM.md` to identify your role in the production pipeline:
     - **Station 1 (Ingestion & Research):** Gemini 1.5 Pro / Perplexity (Parse PDFs, notes, generate flashcards and quiz questions).
     - **Station 2 (Design & Frontend):** Claude Sonnet (Assemble HTML, CSS, 3D flipcards, and Dark Luxury styling).
     - **Station 3 (DevOps & Database):** DeepSeek Coder / Gemini Flash (Supabase SQL seed, `study.html` passcode routing, Git commit/push).
     - **Station 4 (QA & Troubleshooting):** Gemini Flash / Claude (Diagnose build/CDN/mobile errors).

4. **DESIGN STANDARDS**:
   - Palette: Dark Luxury / Moody Forest Green (`#0c120e`, `#111813`), Warm Cream (`#f5f0ea`), Muted Gold (`#c5a880`).
   - Typography: Google Fonts *Playfair Display* (headings) paired with *Plus Jakarta Sans* (body).
   - Mobile-First: Never break desktop layout while adjusting mobile viewports (`@media (max-width: 480px)`).

5. **ONBOARDING AUTOMATION PROTOCOL**:
   - Whenever the user says *"New client [Name] for [Course]"*:
     1. Create `/clients/<FirstName>_<LastName>/` based on `clients/_template/`.
     2. Add uppercase passcode routing into `study.html` inside `handleUnlock()`.
     3. Provide the exact Supabase SQL insert script.
     4. Commit and push to GitHub `main` branch.

6. **WORK LOG UPDATING**:
   - At the conclusion of every session or major milestone, YOU MUST update Section 6 ("Active Project State & AI Work Log") of `BUSINESS_PLAN_AND_AI_SYSTEM.md` with:
     - The current date
     - Exactly what you accomplished
     - Clear, actionable instructions for what the next AI should work on.

