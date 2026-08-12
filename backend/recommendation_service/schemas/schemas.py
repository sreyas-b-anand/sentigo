from pydantic import BaseModel


class RecommendationRequest(BaseModel):
    emotion: str


class RecommendationResponse(BaseModel):
    recommendations: str
    success: bool
    message: str