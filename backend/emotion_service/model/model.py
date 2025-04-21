import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split as tts
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression as LR

train_dataset =pd.read_csv('Emotion_final.csv')

def get_emotion_text(text):
    tokenizer = TfidfVectorizer(sublinear_tf=True, encoding='utf-8', decode_error='ignore', stop_words='english')
    X = tokenizer.fit_transform(train_dataset['Text'])
    y = train_dataset['Emotion']
    x_val =pd.DataFrame({'Text': [text]})
    tokenized_input = tokenizer.transform(x_val['Text'])
    X_train, X_test, y_train, y_test = tts(X, y, test_size=0.2, random_state=42)


    model = LR(random_state=42 , max_iter=1000 , solver='liblinear' , C=10 , class_weight='balanced')

    model.fit(X_train , y_train)

    predictions = model.predict(X_test)
    print(predictions)

   
    proba = model.predict_proba(tokenized_input)
    max_index = proba[0].argmax()

    # Get the corresponding emotion label
    predicted_emotion = model.classes_[max_index]
    
    if proba[0][max_index] < 0.8:
        return {'success': False , 'message': 'Please provide more info' , 'no_emotion' : True }
        

    print(f"\nPredicted Emotion: {predicted_emotion} with confidence {proba[0][max_index]*100:.2f}%")
    return {'emotion': predicted_emotion, 'confidence': round(proba[0][max_index] * 100, 2), 'success': True, 'message': 'Emotion detected' , 'no_emotion' : False}
