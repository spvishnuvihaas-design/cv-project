# Face Recognition Attendance System — React + Python + PostgreSQL + ESP32-CAM

An automated IoT face recognition attendance system using **ESP32-CAM**, **Python Flask**, **OpenCV / face_recognition**, **PostgreSQL**, and **React + Vite**.

## 📌 Architecture
```
[ESP32-CAM + MB]
       │
       │ HTTP POST (multipart/form-data)
       │ Header: X-Camera-Key
       ▼
[Flask Backend (Python)] ───► [OpenCV / face_recognition Engine]
       │
       ├───► [PostgreSQL Database] (Students & Attendance Logs)
       │
       ▼
[React + Vite Dashboard] (Real-time monitoring, registration, CSV exports)
```

---

## 🚀 Getting Started

### 1. Prerequisites
- **Python 3.10+** (Tested on Python 3.14 / 3.12)
- **Node.js LTS** (v20+)
- **PostgreSQL** (or automatic SQLite fallback)

### 2. Backend Setup
```bash
cd backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python app.py
```
Backend will start on: `http://127.0.0.1:5000`

### 3. Frontend Setup
In a new terminal:
```bash
cd frontend
npm install
npm run dev
```
Open Vite dashboard on: `http://localhost:5173`

---

## 📷 ESP32-CAM Setup
1. Open `esp32_cam/esp32_cam_attendance.ino` in Arduino IDE.
2. Update `ssid`, `password`, and your PC's IP address in `serverUrl`.
3. Select Board: **AI Thinker ESP32-CAM**.
4. Upload and open Serial Monitor (115200 baud).

---

## 🗄️ PostgreSQL Setup (Optional / Production)
In pgAdmin or psql:
```sql
CREATE USER attendance_user WITH PASSWORD 'change_this_password';
CREATE DATABASE face_attendance OWNER attendance_user;
```
Configure `backend/.env` with your credentials:
```env
DATABASE_URL=postgresql+psycopg://attendance_user:change_this_password@localhost:5432/face_attendance
```
*(If PostgreSQL is not running, the backend seamlessly uses a local SQLite fallback database).*

