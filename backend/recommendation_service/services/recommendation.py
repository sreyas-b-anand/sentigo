from groq import Groq

from config import settings


class RecommendationService:

    def __init__(self):
        self.client = Groq(
            api_key=settings.groq_api_key
        )

    def generate(self, emotion: str) -> str:

        prompt = f"""
The user is feeling {emotion}.

Recommend exactly 3 inspiring things they can do right now.

Suggestions can include:
- music
- exercise
- short activities
- mindset tips
- food
- drinks

Rules:
- Be specific, helpful, creative, and friendly.
- Keep every recommendation short and concise.
- Do not give generic suggestions such as "go for a walk" or "listen to music".
- If music is suggested, provide a specific song name and artist.
- If exercise is suggested, provide a specific exercise and duration.
- Only ONE of the three recommendations may be music or exercise.
- If you suggest a mindset tip, make it actionable and specific.
- Avoid vague suggestions like "think positive" or "be grateful".
- If the user is sad, suggest a specific type of food.
- If the user is happy, suggest a specific drink or music.
- If the user is angry, suggest a specific exercise to calm down.
- If the user is disgusted, suggest a specific activity to feel better.
- Try to give different recommendations each time.

Output ONLY the 3 recommendations.

Do not include:
- a heading
- explanations
- markdown
- bullet symbols
- * symbols

Example format:

music - song name by artist
activity - specific activity
mindset - specific actionable tip
"""

        response = self.client.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            temperature=0.9,
        )

        return response.choices[0].message.content.strip()