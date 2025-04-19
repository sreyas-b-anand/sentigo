FROM python:3.12-slim

WORKDIR /app


COPY requirements.txt /app/


RUN pip install --no-cache-dir -r requirements.txt


COPY . /app/
COPY data_moods.csv data_moods.csv
EXPOSE 5001
# Run the application
CMD ["python", "app.py"]
