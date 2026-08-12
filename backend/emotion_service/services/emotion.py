import os
import joblib


BASE_DIR = os.path.dirname(
    os.path.dirname(os.path.abspath(__file__))
)

MODEL_PATH = os.path.join(
    BASE_DIR,
    "models",
    "sentigo_emotion_pipeline.joblib"
)

pipeline = joblib.load(MODEL_PATH)

model = pipeline["model"]
vectorizer = pipeline["vectorizer"]
classes = pipeline["classes"]


def get_emotion_text(text: str):

    if not text or not text.strip():
        return {
            "success": False,
            "message": "Please provide some text",
            "no_emotion": True
        }

    tokenized_input = vectorizer.transform([text])

    probabilities = model.predict_proba(
        tokenized_input
    )[0]

    max_index = probabilities.argmax()

    predicted_emotion = model.classes_[max_index]

    confidence = probabilities[max_index]

    if confidence < 0.40:
        return {
            "success": False,
            "message": "Please provide more information",
            "no_emotion": True,
            "confidence": round(confidence * 100, 2)
        }

    return {
        "success": True,
        "emotion": predicted_emotion,
        "confidence": round(confidence * 100, 2),
        "message": "Emotion detected",
        "no_emotion": False
    }