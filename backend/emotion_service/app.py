from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import logging

from services import get_emotion_text
from schemas import EmotionRequest


app = FastAPI(
    title="Sentigo Emotion Service"
)


# ============================================================
# CORS
# ============================================================

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["OPTIONS", "GET", "POST", "DELETE"],
    allow_headers=["*"],
    allow_credentials=True,
)


# ============================================================
# HEALTH CHECK
# ============================================================

@app.get("/ping")
def ping():

    return {
        "message": "Emotion service is running",
        "success": True
    }


# ============================================================
# EMOTION PREDICTION
# ============================================================

@app.post("/get_emotion")
def get_emotion(request: EmotionRequest):

    try:

        response = get_emotion_text(
            request.text
        )

        if not response:

            return {
                "message": "Error in server",
                "success": False
            }

        if response["no_emotion"]:

            return {
                "message": response["message"],
                "success": False,
                "no_emotion": True
            }

        return {
            "message": "Emotion found",
            "success": True,
            "emotion": response["emotion"],
            "confidence": response["confidence"],
            "no_emotion": False
        }

    except Exception as e:

        logging.error(
            f"Error: {e}"
        )

        return {
            "message": "An error occurred",
            "success": False
        }