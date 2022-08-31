from flask_sqlalchemy import SQLAlchemy
from flask import Flask


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data/database.db'
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