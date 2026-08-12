from pydantic import BaseModel

class EmotionRequest(BaseModel):
    text : str
    

class EmotionResponse(BaseModel):
    message: str
    success: bool
    emotion: str | None = None
    confidence: float
    no_emotion: bool = False