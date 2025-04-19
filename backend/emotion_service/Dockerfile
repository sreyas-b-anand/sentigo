FROM python:3.12-slim

WORKDIR /app


COPY requirements.txt /app/


RUN pip install --no-cache-dir -r requirements.txt


COPY . /app/
COPY Emotion_final.csv Emotion_final.csv
EXPOSE 5000
CMD ["python", "app.py"]
