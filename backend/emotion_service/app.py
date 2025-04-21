from flask import Flask , request , jsonify
from flask_cors import CORS
from model import get_emotion_text
import logging , requests
app = Flask(__name__)


CORS(app , methods=['POST', 'GET'])


@app.route('/get_emotion', methods=['POST'])
def get_emotion():
    try:
        data = request.get_json()
        text = data['text']  
        logging.info(f"Received text: {text}")
        response =  get_emotion_text(text)
        if not response:
            return jsonify({'message': 'Error in server' , 'success' : False }), 400

        if response['no_emotion']:
            return jsonify({'message' : 'Please give more info' , 'success' : False , 'no_emotion' : True})
        return jsonify({'message': 'Emotion found' , 'success' : True , 'emotion' : response['emotion'] , 'confidence':response['confidence']}), 200
    
    except Exception as e:
        logging.error(f"Error: {e}")
        return jsonify({'message': 'An error occurred' , 'success' : False}), 500

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
   
    app.run(host='0.0.0.0', port=5000 , debug=True)