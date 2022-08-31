#import os
from flask_sqlalchemy import SQLAlchemy
from flask import Flask
#from sqlalchemy.sql import func
#from sqlalchemy import create_engine
from flask import jsonify, request
from flask_cors import CORS

app = Flask(__name__)
#engine = create_engine("mysql+pymysql://root:Password123!@localhost:3306/database")
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Password123!@mariadb:3306/demo'

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

@app.route('/leaderboard', methods=['POST','GET'])
def highscore():
    if request.method == 'POST':
        args = {
            'score': request.json.get('score')
        }
        highscore = Leaderboard(score=args['score'])
        db.session.add(highscore)
        db.session.commit()
        return {'message': 'successfully created'},201
    else:
        data = db.session.query(Leaderboard).all()
        return jsonify(({'Highscore': [m.to_json() for m in data]}))



if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)