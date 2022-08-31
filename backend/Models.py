import os
from flask_sqlalchemy import SQLAlchemy
from flask import Flask
from sqlalchemy.sql import func
#from sqlalchemy import create_engine

basedir = os.path.abspath(os.path.dirname(__file__))
app = Flask(__name__)
#engine = create_engine("mysql+pymysql://root:Password123!@localhost:3306/database")

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Password123!@localhost:3306/demo'

db = SQLAlchemy(app)


class Leaderboard(db.Model) :
    id = db.Column(db.Integer, primary_key=True,autoincrement=True)
    score = db.Column(db.Integer)
    def to_json(self):
        json_post = {
            'id': self.id,
            'score': self.score
        }
        return json_post

db.create_all()
