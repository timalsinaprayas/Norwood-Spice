# Norwood Spice Restaurant Website

A modern restaurant website for Norwood Spice, featuring authentic Nepali and Indian cuisine. Built with TypeScript React frontend and Java Spring Boot backend.

## Project Structure

```
.
├── frontend/          # TypeScript React application
│   ├── src/
│   │   ├── components/    # Reusable components
│   │   ├── pages/         # Page components (Home, Menu, About)
│   │   └── App.tsx        # Main app component
│   └── package.json
│
└── backend/           # Java Spring Boot application
    ├── src/main/java/
    │   └── com/bellavista/restaurant/
    │       ├── controller/    # REST controllers
    │       ├── service/              # Business logic
    │       ├── repository/          # Data access
    │       └── model/               # Entity models
    └── pom.xml
```

## Features

- **Home Page**: Welcome section with Google Maps location integration
- **Menu Page**: Display menu items with name, description, and images (images on the right side)
- **About Page**: Information about the restaurant, chef, and values
- **REST API**: Backend API for menu data

## Getting Started

### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

The frontend will be available at http://localhost:3000

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Build and run the application:
```bash
mvn spring-boot:run
```

The backend API will be available at http://localhost:8080

The application uses H2 in-memory database and will automatically create the schema and populate initial menu data on startup.

## Technologies Used

### Frontend
- React 18
- TypeScript
- Vite
- React Router
- Axios

### Backend
- Java 17
- Spring Boot 3.2.0
- Spring Data JPA
- H2 Database (in-memory)

## Development

The frontend is configured to proxy API requests to the backend. Make sure both servers are running:
- Frontend: http://localhost:3000
- Backend: http://localhost:8080

