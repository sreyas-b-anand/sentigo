from flask import Flask, request, jsonify
from flask_cors import CORS
import pandas as pd
from mistralai import Mistral
from dotenv import load_dotenv
import os , logging
load_dotenv()
app = Flask(__name__)
CORS(app, methods=['POST', 'GET'])

logging.basicConfig(level=logging.INFO)

def init_mistral():
    api_key = os.getenv("MISTRAL_API_KEY")
    client = Mistral(api_key=api_key)
    return client

@app.route('/get_recommendation', methods=['POST'])
def get_recommendation():
    try:
        data = request.get_json()
        emotion = data.get('emotion')

        if not emotion:
            return jsonify({'message': 'No emotion detected', 'success': False }),400


        mistral_client = init_mistral()

        prompt = f"""
        The user is feeling {emotion}. Recommend 3 inspiring things they can do right now. 
        Suggestions can include music, exercise, short activities, or mindset tips.
        Be specific, helpful, and use a friendly tone.Also make it short and concise.
        Avoid generic responses like "go for a walk" or "listen to music".
        if music is suggested, provide a specific song name and artist.
        If exercise is suggested, provide a specific type of exercise and duration. 
        Only one of the music or exercise suggestions should be included in the response.
        If you suggest a mindset tip, make it actionable and specific.
        Avoid vague suggestions like "think positive" or "be grateful".
        Be creative and think outside the box.
        also if the user is feeling sad, suggest a specific type of food they can eat to feel better.
        If the user is feeling happy, suggest a specific type of drink they can have to feel even better or suggest some music.
        If user is feeling angry, suggest a specific type of exercise they can do to calm down.
        If user is feeling disgusted, suggest a specific type of activity they can do to feel better.
        Make it even shoreter and more concise.
        """

        response = mistral_client.chat.complete(
            model="mistral-large-latest",
            messages=[{"role": "user", "content": prompt}]
        )

        message = response.choices[0].message.content.strip()
        logging.info(f"Received recommendation: {message}")
        return jsonify({'recommendations': message, 'success': True , 'message': 'Here are some recommendations'}),200
    except Exception as e:
        return jsonify({'error': str(e), 'success': False }), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0' ,port=5001, debug=True)
