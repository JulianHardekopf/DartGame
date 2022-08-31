FROM python:3.9-slim

WORKDIR /app
ADD requirements.txt ./
RUN pip install -r requirements.txt

RUN usermod -u 1000 mysql
CMD python /app/Models.py
#CMD python /app/Routes.py

EXPOSE 5000
ADD Models.py ./
#ADD Routes.py ./