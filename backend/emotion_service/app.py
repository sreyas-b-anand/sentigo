from flask import Flask , request , jsonify
from flask_cors import CORS
from model import get_emotion_text
import logging , requests
app = Flask(__name__)


CORS(app , methods=['POST', 'GET'])

def send_emotion(response):
    
    
    if response['success'] == False:
        return {'message': 'No emotion detected' , 'success' : False}
    logging.info(f"Received emotion: {response['predicted_emotion']}")
    res =  requests.post('http://127.0.0.1:5001/get_recommendation' , json={'emotion': response['predicted_emotion']})
    logging.info(f"Received response from recommendation service: {res.json()} , ln:17")
    
    if not res :
        return {'message': 'No recommendation found' , 'success' : False , 'recommendations' :None}
    if res.status_code == 200:
        logging.info(f"Received response: {res.json()} , ln:17")
         # Now safely use the JSON data
        recommendations = res.json().get('recommendations', [])
    else:
        logging.error(f"Failed response: {res.status_code} , ln:17")
        recommendations = []

    return {'sucess': True , 'message': 'Recommendation found' , "recommendations" : recommendations}


@app.route('/get_emotion', methods=['POST'])
def get_emotion():
    try:
        data = request.get_json()
        text = data['text']  
        logging.info(f"Received text: {text}")
        response =  get_emotion_text(text)
        if not response:
            return jsonify({'message': 'No emotion detected' , 'success' : False}), 400

        result =  send_emotion(response)

        if not result:
            return jsonify({'message': 'No recommendation found' , 'success' : False , 'recommendation' : None}), 400
        

        return jsonify({'message': 'Recommendation found' , 'success' : True , 'emotion' : response['predicted_emotion'] , 'recommendations' : result['recommendations']}), 200
    
    except Exception as e:
        logging.error(f"Error: {e}")
        return jsonify({'message': 'An error occurred' , 'success' : False}), 500

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
   
    app.run(port=5000 , debug=True)