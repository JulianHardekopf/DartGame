FROM python:3.9-slim

WORKDIR /app
ADD requirements.txt ./
RUN pip install -r requirements.txt
CMD python /app/Models.py

EXPOSE 5000
ADD Models.py ./