from flask import Flask, request, jsonify
from flask_cors import CORS
import pandas as pd
from mistralai import Mistral
from dotenv import load_dotenv
import os , logging
load_dotenv()
app = Flask(__name__)
CORS(app, methods=['POST', 'GET'])

# Load your dataset
music_dataset = pd.read_csv('data_moods.csv')

emotion_to_music = {
    'happy': 'happy',
    'sadness': 'sad',
    'angry': 'calm',
    'fear': 'calm',
    'disgust': 'calm',
    'surprise': 'energetic'
}


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
            return jsonify({'message': 'No emotion detected', 'success': False}), 400

        if emotion in ['happy', 'sadness']:
            mood = emotion_to_music[emotion]
            recs = music_dataset[music_dataset['mood'] == mood].sample(3)
            return jsonify({
                'recommendations': recs['track_name'].tolist(),
                'success': True,
                'message': 'Here are some music recommendations'
            })

        mistral_client = init_mistral()

        prompt = f"""
        The user is feeling {emotion}. Recommend 3 inspiring things they can do right now. 
        Suggestions can include music, exercise, short activities, or mindset tips.
        Be specific, helpful, and use a friendly tone.Also make it short and concise.
        Avoid generic responses like "go for a walk" or "listen to music".
        
        """

        response = mistral_client.chat(
            model="mistral-large-latest",
            messages=[{"role": "user", "content": prompt}]
        )

        message = response.choices[0].message.content.strip()
        logging.info(f"Received recommendation: {message}")
        return jsonify({'recommendations': message, 'success': True , 'message': 'Here are some recommendations'}),200
    except Exception as e:
        return jsonify({'message': str(e), 'success': False}), 500

if __name__ == "__main__":
    app.run(port=5001, debug=True)
