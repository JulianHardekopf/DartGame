from flask import Flask
from flask import jsonify, request
from flask_sqlalchemy import SQLAlchemy
from Models import Leaderboard
from flask_cors import CORS




app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
db = SQLAlchemy(app)


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