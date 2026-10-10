-- ==============================================================================
-- SEED DEMO STUDY GUIDE FOR TRIVIAL CODE PORTAL
-- Use this in Supabase SQL Editor to populate sample test data
-- ==============================================================================

-- 1. Create Demo Client
INSERT INTO public.clients (id, name, email, service_type, subscription_status)
VALUES (
    'c0000000-0000-0000-0000-000000000001',
    'Elite Prep Academy',
    'demo-client@trivialcode.co',
    'study_guide',
    'active'
)
ON CONFLICT (email) DO NOTHING;

-- 2. Insert Active Demo Study Guide (Expires in 30 days, Passcode: STUDY2026)
INSERT INTO public.study_guides (id, client_id, title, slug, passcode, expires_at, is_active, description)
VALUES (
    'a0000000-0000-0000-0000-000000000001',
    'c0000000-0000-0000-0000-000000000001',
    'Modern Web Systems & Architecture Prep',
    'demo',
    'STUDY2026',
    NOW() + INTERVAL '30 days',
    TRUE,
    'Core exam preparation guide covering databases, APIs, and intentional engineering.'
)
ON CONFLICT (slug) DO UPDATE 
SET passcode = 'STUDY2026', expires_at = NOW() + INTERVAL '30 days';

-- 3. Insert Expired Demo Guide (For testing the expiration screen, Passcode: EXPIRED2026)
INSERT INTO public.study_guides (id, client_id, title, slug, passcode, expires_at, is_active, description)
VALUES (
    'a0000000-0000-0000-0000-000000000002',
    'c0000000-0000-0000-0000-000000000001',
    'Past Cohort Review (Expired)',
    'past-demo',
    'EXPIRED2026',
    NOW() - INTERVAL '2 days',
    TRUE,
    'Session ended guide for testing expiration lockdown.'
)
ON CONFLICT (slug) DO UPDATE 
SET passcode = 'EXPIRED2026', expires_at = NOW() - INTERVAL '2 days';

-- 4. Insert Flashcards into Active Demo Guide
INSERT INTO public.study_modules (study_guide_id, title, module_type, content, order_index)
VALUES 
(
    'a0000000-0000-0000-0000-000000000001',
    'Relational Databases vs NoSQL',
    'flashcard',
    '{"prompt": "What is the primary benefit of ACID compliance in relational databases like PostgreSQL?", "answer": "ACID compliance ensures data validity and integrity even during network errors, power outages, and concurrent transactions."}'::jsonb,
    1
),
(
    'a0000000-0000-0000-0000-000000000001',
    'Row Level Security (RLS)',
    'flashcard',
    '{"prompt": "How does Row Level Security (RLS) protect student data in Supabase?", "answer": "RLS applies security policies at the database layer itself, ensuring clients can only query rows they are explicitly permitted to view."}'::jsonb,
    2
),
(
    'a0000000-0000-0000-0000-000000000001',
    'Software Architecture: Microservices vs Monolith',
    'flashcard',
    '{"prompt": "When should an independent founder choose a modular monolith over microservices?", "answer": "When shipping quickly and reducing operational complexity, allowing clean domain separation without the high DevOps overhead."}'::jsonb,
    3
)
ON CONFLICT DO NOTHING;
