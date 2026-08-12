import logging

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from schemas import (
    RecommendationRequest,
    RecommendationResponse,
)

from services.recommendation import RecommendationService


logging.basicConfig(level=logging.INFO)

logger = logging.getLogger(__name__)


app = FastAPI(
    title="Sentigo Recommendation Service",
    version="1.0.0",
)


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["GET", "POST", "OPTIONS"],
    allow_headers=["*"],
    allow_credentials=False,
)


recommendation_service = RecommendationService()


@app.get("/ping")
def ping():
    return {
        "message": "Recommendation service is running",
        "success": True,
    }


@app.post(
    "/get_recommendation",
    response_model=RecommendationResponse,
)
def get_recommendation(
    request: RecommendationRequest,
):

    try:

        emotion = request.emotion.strip()

        if not emotion:
            return RecommendationResponse(
                recommendations="",
                success=False,
                message="No emotion detected",
            )

        logger.info(
            "Generating recommendation for emotion: %s",
            emotion,
        )

        recommendations = recommendation_service.generate(
            emotion
        )

        return RecommendationResponse(
            recommendations=recommendations,
            success=True,
            message="Here are some recommendations",
        )

    except Exception:

        logger.exception(
            "Error generating recommendations"
        )

        return RecommendationResponse(
            recommendations="",
            success=False,
            message="Failed to generate recommendations",
        )