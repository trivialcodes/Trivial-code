-- ==============================================================================
-- TRIVIAL CODE — SUPABASE CLIENT SEED & SYNCHRONIZATION SCRIPT
-- RUN THIS SCRIPT IN SUPABASE SQL EDITOR TO SEED BOTH CLIENTS:
-- 1. Brandon Thomas (Greek & Roman Mythology — 5 Months Expiration)
-- 2. Melissa Mendez (Introduction to Python — 2 Days Expiration)
-- All demo/dummy study guides are removed.
-- ==============================================================================

DO $$
DECLARE
  v_brandon_id UUID;
  v_melissa_id UUID;
  v_greek_guide_id UUID;
  v_python_guide_id UUID;
BEGIN
  -- 1. Clean out any previous demo guides if needed
  DELETE FROM public.study_guides WHERE slug IN ('demo', 'past-demo', 'sample');

  -- 2. Insert or update Client: Brandon Thomas
  INSERT INTO public.clients (name, email, service_type, subscription_status, notes)
  VALUES (
    'Brandon Thomas',
    'brandon@trivialcode.co',
    'study_guide',
    'active',
    'Founder study guide: CLST 036 Greek & Roman Mythology'
  )
  ON CONFLICT (email) DO UPDATE 
    SET name = EXCLUDED.name, service_type = EXCLUDED.service_type
  RETURNING id INTO v_brandon_id;

  -- 3. Insert or update Client: Melissa Mendez
  INSERT INTO public.clients (name, email, service_type, subscription_status, notes)
  VALUES (
    'Melissa Mendez',
    'melissa.mendez@university.edu',
    'study_guide',
    'active',
    'College student client: CS 101 Introduction to Python'
  )
  ON CONFLICT (email) DO UPDATE 
    SET name = EXCLUDED.name, service_type = EXCLUDED.service_type
  RETURNING id INTO v_melissa_id;

  -- 4. Create Study Guide for Brandon Thomas (Greek Mythology, 5 Months Expiration)
  -- 5 Months from now: NOW() + INTERVAL '5 months' (March 11, 2027)
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
    v_brandon_id,
    'CLST 036 — Greek & Roman Mythology',
    'clst-036-mythology',
    'CLST036',
    NOW() + INTERVAL '5 months',
    TRUE,
    'Comprehensive study guide covering Hesiod, Aeschylus, Ovid, Euripides, and Seneca with 20 flashcards and 20 quiz questions.'
  )
  ON CONFLICT (slug) DO UPDATE 
    SET passcode = EXCLUDED.passcode,
        expires_at = NOW() + INTERVAL '5 months',
        is_active = TRUE,
        client_id = v_brandon_id
  RETURNING id INTO v_greek_guide_id;

  -- 5. Create Study Guide for Melissa Mendez (Python 101, 2 Days Expiration)
  -- 2 Days from now: NOW() + INTERVAL '2 days' (October 13, 2026)
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
    v_melissa_id,
    'CS 101 — Introduction to Python',
    'cs101-python',
    'PYTHON2026',
    NOW() + INTERVAL '2 days',
    TRUE,
    'Intro to Python study guide with memory model, data structures, OOP, 20 flashcards, and 15 quiz questions.'
  )
  ON CONFLICT (slug) DO UPDATE 
    SET passcode = EXCLUDED.passcode,
        expires_at = NOW() + INTERVAL '2 days',
        is_active = TRUE,
        client_id = v_melissa_id
  RETURNING id INTO v_python_guide_id;

  RAISE NOTICE 'SUCCESS: Brandon Thomas Guide ID: % (Expires in 5 Months)', v_greek_guide_id;
  RAISE NOTICE 'SUCCESS: Melissa Mendez Guide ID: % (Expires in 2 Days)', v_python_guide_id;
END $$;
