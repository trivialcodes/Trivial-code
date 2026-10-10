# TRIVIAL CODE — STUDY GUIDE PRODUCTION SYSTEM & ARCHITECTURE MANUAL

> **MANDATORY GUIDE FOR ALL AI AGENTS & DEVELOPERS BUILDING STUDY GUIDES FOR TRIVIAL CODE:**
> This document details the exact technical structure, UI/UX requirements, security mechanisms, and ingestion workflows for creating interactive, premium study guides.
> Every study guide produced by or for Trivial Code must follow this specification.

---

## 1. Core Architectural Pillars

Every study guide consists of:
1. **Passcode & Single-Concurrent-Viewer Gate:**
   - User enters a unique passcode.
   - **One viewer at a time**: A session heartbeat token ensures that if User A is logged in, User B cannot view the guide simultaneously with the same code.
   - **Time-bound expiration**: Guides automatically lock down when their expiration timestamp passes.
2. **Left Navigation Sidebar (Collapsible & Mobile Hamburger):**
   - Branded Header (Course code, university/institution, exam label).
   - Category labels with clean iconography.
   - Live interactive **Progress Bar / Progress Ring** tracking completion across flashcards and quizzes.
3. **Structured Chapter / Content Breakdown:**
   - Divided cleanly by: **Textbook Chapters, Lecture Dates, Exam Units, or Concept Domains**.
   - **Interactive Elements**:
     - Tap-to-reveal definition cards (`.term-card.open`)
     - Color-coded concept callouts (`card-accent`, `card-blue`, `card-teal`, `card-purple`, `card-red`)
     - Comparative tables (`<table>` with styled headers)
     - Interactive SVG tree diagrams / syntax or flow visualizers
     - Animated data bars / progress bars (`.wo-bar`)
     - Pro-tip and mnemonic callout boxes (`.tip`)
4. **Interactive Flashcards:**
   - 3D CSS flip animations (`perspective: 1000px`, `transform: rotateY(180deg)`).
   - Topic tags, question prompt, answer explanation, and bidirectional navigation controls.
5. **Interactive Quizzes with Instant Explanations:**
   - Modular question blocks with multi-choice options.
   - Instant visual feedback: Correct (green wash) vs. Incorrect (soft red wash).
   - Comprehensive explanation drawer revealing *why* the answer is correct and breaking down common traps.
   - Real-time score counter (Correct / Answered / Percentage score) + Reset capabilities.

---

## 2. Ingestion Protocol: Creating Study Guides from Raw Course Material

When client materials are provided (PDFs, lecture slides, syllabus, textbook chapters, audio transcripts, or assignment prompts), future AI models must process them using the following step-by-step pipeline:

```
[Raw Materials: PDF / Slides / Syllabus]
                 ↓
[1. Course Metadata Extraction] → Course Name, Institution, Target Exam Date, Topics
                 ↓
[2. Domain Hierarchy Breakdown] → Break into 5-8 Core Modules / Chapters
                 ↓
[3. Core Concept & Term Extraction] → Minimum 20-30 Flashcard Terms (Term + Deep Definition)
                 ↓
[4. Diagram & Data Component Design] → Tables, SVG charts, comparison boxes, rules
                 ↓
[5. Practice Question Formulation] → 15-30 Multiple-Choice Questions with in-depth explanations
                 ↓
[6. Code Compilation] → Deploy into standardized single-file or portal-rendered guide
```

---

## 3. Single-Concurrent-Viewer & Security Specification

To prevent sharing passcodes with multiple simultaneous users:
1. When a user enters their passcode, a unique `session_token` (UUID) is generated in `localStorage` and sent to Supabase.
2. The database updates `active_session_token = current_token` and `last_active_at = NOW()`.
3. The page sends a heartbeat ping every 15 seconds to update `last_active_at`.
4. If a second user enters the same passcode, they overwrite or are blocked by the active session if `NOW() - last_active_at < 30 seconds`.
5. If another device takes over the session, the first user's screen displays:
   > **"Session Active on Another Device: This access code only permits one viewer at a time."**

---

## 4. Design & Typography Tokens

| Element | Specification |
| :--- | :--- |
| **Heading Font** | `'Playfair Display', Georgia, serif` |
| **Body Font** | `'DM Sans' / 'Plus Jakarta Sans', sans-serif` |
| **Monospace / Code** | `'DM Mono', monospace` |
| **Color Palette** | Dark / Warm Editorial: `--bg: #0c120e` (or warm cream `#f5f3ee`), `--accent: #c5a880` (gold), `--accent2: #5548a8` (purple), `--teal: #1a8a78`, `--green: #2d7a4f`, `--red: #b83030` |

---

## 5. Standard Study Guide Checklist

Before shipping any study guide to a client:
- [ ] Passcode validation and single-viewer concurrency verified.
- [ ] Expiration date timer functioning in header.
- [ ] Sidebar links scroll smoothly or switch active page views without page reloads.
- [ ] Flashcards flip smoothly on both desktop and mobile touch.
- [ ] All quiz questions have detailed, educational explanations for each option.
- [ ] Content is protected against easy scraping (right-click / print styling disabled).
