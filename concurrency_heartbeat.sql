-- ==============================================================================
-- ADD SINGLE-CONCURRENT-VIEWER & HEARTBEAT TO SUPABASE
-- Ensures each passcode can only be viewed by 1 person at a time
-- ==============================================================================

-- 1. Add session tracking columns to study_guides
ALTER TABLE public.study_guides 
ADD COLUMN IF NOT EXISTS active_session_token TEXT,
ADD COLUMN IF NOT EXISTS last_heartbeat_at TIMESTAMPTZ;

-- 2. SECURE FUNCTION: Claim or verify exclusive session
CREATE OR REPLACE FUNCTION public.claim_study_session(
    guide_slug TEXT,
    user_passcode TEXT,
    client_session_token TEXT,
    force_takeover BOOLEAN DEFAULT FALSE
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    guide RECORD;
    is_in_use BOOLEAN;
BEGIN
    -- Check if guide exists and passcode matches
    SELECT * INTO guide
    FROM public.study_guides
    WHERE slug = guide_slug
      AND passcode = user_passcode
      AND is_active = TRUE;

    IF guide.id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'error', 'Invalid study guide or passcode.');
    END IF;

    -- Enforce expiration
    IF NOW() > guide.expires_at THEN
        RETURN jsonb_build_object(
            'success', false, 
            'error', 'EXPIRED',
            'message', 'This study guide session has expired. Please contact your instructor for renewed access.'
        );
    END IF;

    -- Concurrency check: is another session currently active? (Heartbeat within last 35 seconds)
    is_in_use := (
        guide.active_session_token IS NOT NULL AND
        guide.active_session_token != client_session_token AND
        guide.last_heartbeat_at IS NOT NULL AND
        guide.last_heartbeat_at > (NOW() - INTERVAL '35 seconds')
    );

    IF is_in_use AND NOT force_takeover THEN
        RETURN jsonb_build_object(
            'success', false,
            'error', 'IN_USE',
            'message', 'This study guide is currently active on another device. This code only permits one viewer at a time.'
        );
    END IF;

    -- Claim session
    UPDATE public.study_guides
    SET active_session_token = client_session_token,
        last_heartbeat_at = NOW()
    WHERE id = guide.id;

    RETURN jsonb_build_object(
        'success', true,
        'title', guide.title,
        'description', guide.description,
        'expires_at', guide.expires_at
    );
END;
$$;

-- 3. HEARTBEAT FUNCTION: Keep current session alive
CREATE OR REPLACE FUNCTION public.send_session_heartbeat(
    guide_slug TEXT,
    client_session_token TEXT
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    guide RECORD;
BEGIN
    SELECT * INTO guide
    FROM public.study_guides
    WHERE slug = guide_slug;

    IF guide.id IS NULL THEN
        RETURN jsonb_build_object('success', false, 'error', 'Guide not found.');
    END IF;

    -- If another user took over the session, notify client
    IF guide.active_session_token != client_session_token THEN
        RETURN jsonb_build_object(
            'success', false,
            'error', 'KICKED',
            'message', 'Your session was ended because this code was accessed on another device.'
        );
    END IF;

    -- Update timestamp
    UPDATE public.study_guides
    SET last_heartbeat_at = NOW()
    WHERE id = guide.id;

    RETURN jsonb_build_object('success', true);
END;
$$;
