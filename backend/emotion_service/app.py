from flask import Flask , request , jsonify
from flask_cors import CORS
from model import get_emotion_text
import logging , requests
app = Flask(__name__)


CORS(app , methods=['POST', 'GET'])

def send_emotion(response):
    
    logging.info(f"Received emotion: {res['predicted_emotion']}")
    
    if response['success'] == False:
        return jsonify({'message': 'No emotion detected' , 'success' : False}), 400
    
    res = requests.post('http://recommendation_service:5001/get_recommendation' , json={'emotion': response['predicted_emotion']})
    
    
    if not res :
        return jsonify({'message': 'No recommendation found' , 'success' : False}), 400

    return jsonify({'sucess': True , 'message': 'Recommendation found'})
app.route('/get_emotion', methods=['POST'])
def get_emotion():
    data = request.get_json()
    text = data['text']  
    logging.info(f"Received text: {text}")
    response = get_emotion_text(text)
    if not response:
        return jsonify({'message': 'No emotion detected' , 'success' : False}), 400
    result = send_emotion(response)
    
    if not result:
        return jsonify({'message': 'No recommendation found' , 'success' : False}), 400
    logging.info(f"Received recommendation: {result}")
    
    return jsonify({'message': 'Recommendation found' , 'success' : True , 'emotion' : response['predicted_emotion'] , 'recommendation' : result['recommendation']}), 200
    
    

if __name__ == '__main__':
    
    logging.basicConfig(level=logging.INFO)
    app.run(port=5000 , debug=True)