-- 1. Create Tables

-- users table
CREATE TABLE IF NOT EXISTS users (
  uid TEXT PRIMARY KEY,
  phone TEXT NOT NULL,
  name TEXT NOT NULL DEFAULT '',
  photo_url TEXT,
  dob DATE,
  gender TEXT,
  skin_type TEXT,
  fitzpatrick_type INTEGER,
  known_conditions JSONB DEFAULT '[]',
  allergies TEXT,
  latest_tip TEXT,
  latest_tip_date DATE,
  onboarding_step INTEGER NOT NULL DEFAULT 0,
  is_onboarding_complete BOOLEAN NOT NULL DEFAULT FALSE,
  fcm_token TEXT,
  subscription_status TEXT NOT NULL DEFAULT 'free',
  subscription_expires_at TIMESTAMPTZ,
  revenuecat_user_id TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- scan_reports table
CREATE TABLE IF NOT EXISTS scan_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id TEXT NOT NULL REFERENCES users(uid) ON DELETE CASCADE,
  scan_mode TEXT NOT NULL,
  photo_straight_url TEXT NOT NULL,
  photo_left_url TEXT NOT NULL,
  photo_right_url TEXT NOT NULL,
  user_concern TEXT,
  detected_conditions JSONB,
  skin_health_score INTEGER,
  zone_wise_summary JSONB,
  severity JSONB,
  causes JSONB,
  what_to_do JSONB,
  doctor_alert BOOLEAN NOT NULL DEFAULT FALSE,
  doctor_alert_reason TEXT,
  face_structure TEXT,
  medical_disclaimer TEXT,
  gemini_raw_response JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- chat_messages table
CREATE TABLE IF NOT EXISTS chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id TEXT NOT NULL REFERENCES users(uid) ON DELETE CASCADE,
  role TEXT NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- chat_archive table
CREATE TABLE IF NOT EXISTS chat_archive (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id TEXT NOT NULL,
  role TEXT NOT NULL,
  message TEXT NOT NULL,
  original_created_at TIMESTAMPTZ NOT NULL,
  archived_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Create updated_at trigger for users
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- 3. Enable Row Level Security (RLS) on all tables

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE scan_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_archive ENABLE ROW LEVEL SECURITY;

-- 4. Create RLS Policies for users table

CREATE POLICY "users_select_own" ON users
  FOR SELECT USING (uid = auth.uid()::text);

CREATE POLICY "users_update_own" ON users
  FOR UPDATE USING (uid = auth.uid()::text);

CREATE POLICY "users_insert_own" ON users
  FOR INSERT WITH CHECK (uid = auth.uid()::text);

CREATE POLICY "users_delete_own" ON users
  FOR DELETE USING (uid = auth.uid()::text);

-- 5. Create RLS Policies for scan_reports table

CREATE POLICY "scan_select_own" ON scan_reports
  FOR SELECT USING (user_id = auth.uid()::text);

CREATE POLICY "scan_insert_own" ON scan_reports
  FOR INSERT WITH CHECK (user_id = auth.uid()::text);

CREATE POLICY "scan_update_own" ON scan_reports
  FOR UPDATE USING (user_id = auth.uid()::text);

CREATE POLICY "scan_delete_own" ON scan_reports
  FOR DELETE USING (user_id = auth.uid()::text);

-- 6. Create RLS Policies for chat_messages table

CREATE POLICY "chat_select_own" ON chat_messages
  FOR SELECT USING (user_id = auth.uid()::text);

CREATE POLICY "chat_insert_own" ON chat_messages
  FOR INSERT WITH CHECK (user_id = auth.uid()::text);

CREATE POLICY "chat_delete_own" ON chat_messages
  FOR DELETE USING (user_id = auth.uid()::text);

-- 7. Initialize Storage Buckets (inserts into storage.buckets table)

INSERT INTO storage.buckets (id, name, public)
VALUES ('profile-photos', 'profile-photos', false)
ON CONFLICT (id) DO NOTHING;

INSERT INTO storage.buckets (id, name, public)
VALUES ('scan-photos', 'scan-photos', false)
ON CONFLICT (id) DO NOTHING;

-- 8. Create Storage RLS Policies

CREATE POLICY "profile_photos_user_access" ON storage.objects
  FOR ALL USING (
    bucket_id = 'profile-photos'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "scan_photos_user_access" ON storage.objects
  FOR ALL USING (
    bucket_id = 'scan-photos'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );
