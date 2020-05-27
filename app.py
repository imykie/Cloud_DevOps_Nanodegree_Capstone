from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return '<h1 style="text-align:center;margin-top:50px;">This is Udacity Cloud DevOps Engineer Nanodegree Capstone Project by Michael Olatunji!</h1>'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)