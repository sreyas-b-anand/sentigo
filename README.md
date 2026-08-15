# Sentigo

Sentigo is a mobile application designed to analyze user emotions and provide personalized recommendations. It consists of two **FastAPI microservices** (`emotion_service` and `recommendation_service`) and a **Flutter-based frontend**.

## Features

* **Emotion Detection**: Analyzes user input and detects the underlying emotion using the `emotion_service`.
* **Personalized Recommendations**: Generates recommendations based on the detected emotion using the `recommendation_service`.
* **Microservice Architecture**: Separates emotion detection and recommendation generation into independent services.
* **AI-Powered Recommendations**: Uses the Groq API to generate personalized recommendations.

---

## Images

<p float="left">
  <img src="images/example1.png" width="25%" />
  <img src="images/example2.png" width="25%" />
  <img src="images/example3.png" width="25%" style="margin-right: 5%"/>
</p>

---

## Architecture

The project is divided into three main components:

### 1. Backend Microservices

* **`emotion_service`**: A FastAPI service that analyzes user input and predicts the user's emotion using the trained emotion classification model.
* **`recommendation_service`**: A FastAPI service that generates personalized recommendations based on the detected emotion using the Groq API.

### 2. Frontend

* A **Flutter application** that communicates with the backend microservices and provides a user-friendly mobile interface.

### 3. Docker Compose

* **Docker Compose** is used to orchestrate the backend microservices for local development and deployment.

---

## Prerequisites

* Docker and Docker Compose
* Flutter SDK
* Android Studio (for Android emulator and Flutter development)
* A **Groq API key**

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/sreyas-b-anand/sentigo
cd sentigo
```

### 2. Environment Setup

Create a `.env` file inside the `recommendation_service` directory:

```env
GROQ_API_KEY=YOUR_API_KEY
```

The Groq API key is required by the recommendation service to generate personalized recommendations.

---

### 3. Configure Backend URLs

The Flutter application stores the backend API URLs inside the `config` folder:

```text
frontend/
└── lib/
    └── config/
```

Open the configuration file inside this folder and update the API URLs according to your backend deployment:

```dart
const emotionServiceUrl = 'YOUR_EMOTION_SERVICE_URL';
const recommendationServiceUrl = 'YOUR_RECOMMENDATION_SERVICE_URL';
```

For example:

```dart
const emotionServiceUrl = 'https://your-emotion-service-url';
const recommendationServiceUrl = 'https://your-recommendation-service-url';
```

> **Note:** Update these URLs whenever you want to connect the Flutter application to a different backend deployment.

---

### 4. Backend Setup

Navigate to the backend directory:

```bash
cd backend
```

Build and start the microservices using Docker Compose:

```bash
docker-compose up --build
```

This starts:

* **Emotion Service** → Port `5000`
* **Recommendation Service** → Port `5001`

Both services are implemented using **FastAPI**.

---

### 5. Frontend Setup

Navigate to the Flutter frontend:

```bash
cd frontend
```

Install the required dependencies:

```bash
flutter pub get
```

---

### 6. Run the Application

Make sure the backend services are running or that the configured backend URLs point to deployed services.

Then start the Flutter application:

```bash
flutter run
```

The application can be run using an Android emulator or a connected Android device.

---

## Tech Stack

### Frontend

* Flutter
* Dart
* Riverpod
* HTTP

### Backend

* Python
* FastAPI
* Scikit-learn
* Groq API

### Infrastructure

* Docker
* Docker Compose

---

## Project Structure

```text
sentigo/
├── backend/
│   ├── emotion_service/
│   ├── recommendation_service/
│   └── docker-compose.yml
│
├── frontend/
│   ├── lib/
│   │   ├── config/
│   │   │   └── ...
│   │   └── ...
│   └── ...
│
├── images/
│   ├── example1.png
│   └── example2.png
│
└── README.md
```
