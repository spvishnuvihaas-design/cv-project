-- ========================================================
-- Supabase Schema for Face Recognition Attendance System
-- Run this script in your Supabase project's "SQL Editor"
-- ========================================================

-- 1. Create Students Table
CREATE TABLE IF NOT EXISTS public.students (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    roll_number VARCHAR(64) UNIQUE NOT NULL,
    department VARCHAR(100) DEFAULT 'General',
    photo_path VARCHAR(255),
    face_encoding TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL
);

-- Index for fast roll number lookups
CREATE INDEX IF NOT EXISTS idx_students_roll_number ON public.students (roll_number);

-- 2. Create Attendance Records Table
CREATE TABLE IF NOT EXISTS public.attendance_records (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT REFERENCES public.students(id) ON DELETE SET NULL,
    student_name VARCHAR(120) NOT NULL,
    roll_number VARCHAR(64),
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    date_str VARCHAR(10) NOT NULL,
    status VARCHAR(32) DEFAULT 'Present' NOT NULL,
    confidence FLOAT,
    camera_id VARCHAR(64) DEFAULT 'ESP32-CAM',
    snapshot_path VARCHAR(255)
);

-- Indexes for date & student search performance
CREATE INDEX IF NOT EXISTS idx_attendance_date ON public.attendance_records (date_str);
CREATE INDEX IF NOT EXISTS idx_attendance_timestamp ON public.attendance_records (timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_attendance_student_id ON public.attendance_records (student_id);

-- 3. Create Camera Devices Table
CREATE TABLE IF NOT EXISTS public.camera_devices (
    id BIGSERIAL PRIMARY KEY,
    device_name VARCHAR(64) UNIQUE DEFAULT 'ESP32-CAM' NOT NULL,
    ip_address VARCHAR(45),
    last_frame_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    total_frames INTEGER DEFAULT 0 NOT NULL,
    status VARCHAR(20) DEFAULT 'online' NOT NULL
);

-- Insert default ESP32-CAM device entry
INSERT INTO public.camera_devices (device_name, status)
VALUES ('ESP32-CAM', 'standby')
ON CONFLICT (device_name) DO NOTHING;

-- 4. Enable Row Level Security (RLS) & Allow Read/Write for Authenticated and Anon keys
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.camera_devices ENABLE ROW LEVEL SECURITY;

-- Policies for public / anon API access
CREATE POLICY "Allow public read access to students" ON public.students FOR SELECT USING (true);
CREATE POLICY "Allow public insert/update to students" ON public.students FOR ALL USING (true);

CREATE POLICY "Allow public read access to attendance" ON public.attendance_records FOR SELECT USING (true);
CREATE POLICY "Allow public insert to attendance" ON public.attendance_records FOR ALL USING (true);

CREATE POLICY "Allow public read access to camera_devices" ON public.camera_devices FOR SELECT USING (true);
CREATE POLICY "Allow public update to camera_devices" ON public.camera_devices FOR ALL USING (true);
