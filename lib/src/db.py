from flask import Flask
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
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























"""
@app.route('/leaderboard', methods=['POST','GET'])
def highscore():
    if request.method == 'POST':
        args = {
            'score': request.json.get('score')
        }
        highscore = Leaderboard(title=args['score'])
        db.session.add(highscore)
        db.session.commit()
        return {'message': 'successfully created'},201
    else:
        data = db.session.query(Leaderboard).all()
        return jsonify(({'Products': [m.to_json() for m in data]}))


"""