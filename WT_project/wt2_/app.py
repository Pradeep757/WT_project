from flask import Flask, render_template, request,jsonify,Response,make_response
from chatterbot import ChatBot
from chatterbot.trainers import ChatterBotCorpusTrainer
from flask_cors import CORS

 
app = Flask(__name__)
CORS(app)
 
english_bot = ChatBot("Chatterbot", storage_adapter="chatterbot.storage.SQLStorageAdapter")
trainer = ChatterBotCorpusTrainer(english_bot)

trainer.train("chatterbot.corpus.english")
trainer.train(
    "chatterbot.corpus.english.greetings",
    "chatterbot.corpus.english.conversations"
)

 
@app.route("/")
def home():
    return render_template("index.html")
 
@app.route("/get")
def get_bot_response():
    userText = request.args.get('msg')
    return str(english_bot.get_response(userText))
 
 
@app.route("/api/chat",methods=['post'])
def respond():
	data = request.json
	#print(data)
	msg = data['msg']
	print(msg)
	resp = str(english_bot.get_response(msg))
	i = dict()
	i['msg'] = resp
	i = jsonify(i)
	response = make_response(i,200)
	response.headers['content-type'] = 'application/json'
	return response;
	
	
 
if __name__ == "__main__":
    app.run()
