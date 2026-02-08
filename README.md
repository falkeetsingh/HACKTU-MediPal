# FitCred Medical Compliance PWA

A hospital-grade Progressive Web App for tracking medical exercise compliance. Built with MERN stack for clinical documentation used by doctors and patients.

## Features

### Patient Features

- View active prescriptions
- Start and complete exercise sessions
- Track compliance and progress
- View session history and streaks
- Receive notifications

### Doctor Features

- Patient dashboard with compliance overview
- Create exercise prescriptions
- View patient compliance trends
- Record treatment decisions
- Monitor session history

## Tech Stack

**Frontend:**

- React 18
- Vite
- React Router
- Tailwind CSS
- Recharts
- PWA (Service Worker + Manifest)

**Backend:**

- Node.js
- Express.js
- MongoDB + Mongoose
- JWT Authentication
- RESTful API

## Getting Started

### Prerequisites

- Node.js (v18+)
- MongoDB (v5+)
- npm or yarn

### Installation

1. **Install Backend Dependencies**

```bash
cd backend
npm install
```

2. **Install Frontend Dependencies**

```bash
cd frontend
npm install
```

3. **Configure Environment**

Backend `.env`:

```
PORT=5000
MONGODB_URI=mongodb://localhost:27017/fitcred
JWT_SECRET=your_secret_key
NODE_ENV=development
FACE_SERVICE_URL=http://localhost:8001
```

4. **Start MongoDB**

```bash
mongod
```

5. **Seed Database (Optional)**

```bash
cd backend
node seed.js
```

6. **Start Backend Server**

```bash
cd backend
npm run dev
```

7. **Start Frontend**

```bash
cd frontend
npm run dev
```

The app will be available at `http://localhost:5173`

8. **Start Face Verification Service (Python)**

```bash
cd ../python/face-detection
uvicorn app.main:app --host 0.0.0.0 --port 8001
```

The FastAPI service only stores face embeddings. See `python/face-detection/README.md` for full setup details (model download, curl tests, and env overrides).

## Demo Credentials

After seeding the database:

**Doctor:**

- Email: `doctor@fitcred.com`
- Password: `password123`

**Patient (Good Compliance):**

- Email: `patient@fitcred.com`
- Password: `password123`

**Patient (Poor Compliance):**

- Email: `patient2@fitcred.com`
- Password: `password123`

## Project Structure

```
FitCred/
├── backend/
│   ├── models/          # Mongoose schemas
│   ├── routes/          # API endpoints
│   ├── middleware/      # Auth middleware
│   ├── server.js        # Express app
│   └── seed.js          # Demo data
├── frontend/
│   ├── src/
│   │   ├── components/  # Reusable components
│   │   ├── context/     # React Context (Auth)
│   │   ├── pages/       # Route pages
│   │   │   ├── patient/ # Patient views
│   │   │   └── doctor/  # Doctor views
│   │   ├── utils/       # API client
│   │   ├── App.jsx      # Main app + routing
│   │   └── main.jsx     # Entry point
│   ├── index.html
│   └── vite.config.js
└── README.md
```

## API Endpoints

### Authentication

- `POST /auth/signup` - Create patient with biometric registration
- `POST /auth/login` - User login
- `GET /auth/me` - Get current user
- `POST /auth/logout` - Logout

### Users

- `GET /users/:id` - Get user by ID
- `GET /users?role=patient` - Get users by role
- `POST /users` - Create user (Admin only)

### Prescriptions

- `POST /prescriptions` - Create prescription
- `GET /prescriptions/:id` - Get prescription
- `GET /prescriptions?patientId=` - List prescriptions

### Sessions

- `POST /sessions/start` - Start session
- `POST /sessions/complete` - Complete session
- `GET /sessions?patientId=` - List sessions
- `POST /face/register` - Refresh stored embedding (patient/doctor)
- `POST /face/verify` - On-demand verification (uses FastAPI service)

### Compliance

- `GET /compliance/patient/:id` - Get patient compliance
- `GET /compliance/summary/:doctorId` - Doctor summary

### Decisions

- `POST /decisions` - Record decision
- `GET /decisions?patientId=` - List decisions

### Notifications

- `POST /notifications/schedule` - Schedule notification
- `GET /notifications?userId=` - Get notifications

### Walking + Face Verification

- Walking prescriptions can now be authored from the doctor dashboard.
- Patients complete walking sessions in real time with two randomized face challenges (skip allowed but downgrades verification).
- Session records include `verificationEvents` + `verificationSummary` for clinicians.
- Sessions automatically call the FastAPI biometric service; raw images are never persisted.

## Design Principles

- **Minimalist UI**: Hospital-grade design with neutral colors
- **Audit-Friendly**: Immutable records, complete logging
- **Role-Based Access**: Strict permission controls
- **Medical-Grade**: Professional, calm interface
- **PWA Support**: Offline-capable, installable

## AI Integration Points

The system is designed for future AI verification integration:

- `verified` (boolean) - Session verification status
- `confidence` (number) - AI confidence score
- `verificationSource` (string) - Verification method

Currently using mock data. AI APIs can be plugged in at:

- `backend/routes/sessions.js` - Session verification
- `frontend/pages/patient/SessionLive.jsx` - Real-time monitoring

## Development

**Backend Dev Mode:**

```bash
cd backend
npm run dev  # Uses nodemon
```

**Frontend Dev Mode:**

```bash
cd frontend
npm run dev  # Uses Vite HMR
```

**Build for Production:**

```bash
cd frontend
npm run build
```

## Security

- JWT-based authentication
- HTTP-only cookies option
- Role-based access control
- Password hashing with bcrypt
- Input validation

## License

Proprietary - Medical Software

## Support

For issues or questions, contact the development team.
