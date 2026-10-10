-- ==============================================================================
-- TRIVIAL CODE — CORE DATABASE SCHEMA
-- Handles:
-- 1. Clients & Subscribers
-- 2. Passcode-Protected & Auto-Expiring Study Guides
-- 3. Study Modules (Questions, Flashcards, Guides)
-- 4. Leads & Inquiries
-- ==============================================================================

-- Enable UUID extension if not enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. CLIENTS TABLE
CREATE TABLE IF NOT EXISTS public.clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    service_type TEXT DEFAULT 'website', -- 'study_guide', 'website', 'app', 'masterclass'
    subscription_status TEXT DEFAULT 'inactive', -- 'active', 'inactive', 'canceled'
    notes TEXT
);

-- 2. STUDY GUIDES TABLE
CREATE TABLE IF NOT EXISTS public.study_guides (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    client_id UUID REFERENCES public.clients(id) ON DELETE SET NULL,
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL, -- e.g., 'mcat-prep-2026' or 'nursing-101'
    passcode TEXT NOT NULL,     -- Passcode required to enter
    expires_at TIMESTAMPTZ NOT NULL, -- Expiring date & time
    is_active BOOLEAN DEFAULT TRUE,
    description TEXT
);

-- 3. STUDY MODULES TABLE (Flashcards, Quizzes, Study Chapters)
CREATE TABLE IF NOT EXISTS public.study_modules (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    study_guide_id UUID NOT NULL REFERENCES public.study_guides(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    module_type TEXT DEFAULT 'flashcard', -- 'flashcard', 'quiz', 'notes'
    content JSONB NOT NULL DEFAULT '{}'::jsonb,
    order_index INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. CONTACT LEADS & INQUIRIES
CREATE TABLE IF NOT EXISTS public.contact_leads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    project_type TEXT,
    message TEXT,
    status TEXT DEFAULT 'new' -- 'new', 'contacted', 'closed'
);

-- ==============================================================================
-- ROW LEVEL SECURITY (RLS) & PUBLIC SAFE VERIFICATION FUNCTION
-- Prevents student scraping of expired study guides
-- ==============================================================================

ALTER TABLE public.study_guides ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.study_modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contact_leads ENABLE ROW LEVEL SECURITY;

-- Allow anonymous visitors to submit contact inquiries
CREATE POLICY "Allow public insert into contact_leads"
    ON public.contact_leads
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- SECURE RPC FUNCTION: Verify Passcode and return study content ONLY if not expired
CREATE OR REPLACE FUNCTION public.access_study_guide(
    guide_slug TEXT,
    user_passcode TEXT
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    guide RECORD;
    modules JSONB;
BEGIN
    -- Check if guide exists with the correct passcode
    SELECT * INTO guide
    FROM public.study_guides
    WHERE slug = guide_slug
      AND passcode = user_passcode
      AND is_active = TRUE;

    IF guide.id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'error', 'Invalid study guide or passcode.');
    END IF;

    -- Enforce auto-expiration check
    IF NOW() > guide.expires_at THEN
        RETURN jsonb_build_object(
            'success', false, 
            'error', 'EXPIRED',
            'message', 'This study guide session has expired. Please contact your instructor to renew access.'
        );
    END IF;

    -- Fetch modules for the verified guide
    SELECT jsonb_agg(
        jsonb_build_object(
            'id', sm.id,
            'title', sm.title,
            'module_type', sm.module_type,
            'content', sm.content,
            'order_index', sm.order_index
        ) ORDER BY sm.order_index ASC
    ) INTO modules
    FROM public.study_modules sm
    WHERE sm.study_guide_id = guide.id;

    RETURN jsonb_build_object(
        'success', true,
        'title', guide.title,
        'description', guide.description,
        'expires_at', guide.expires_at,
        'modules', COALESCE(modules, '[]'::jsonb)
    );
END;
$$;
