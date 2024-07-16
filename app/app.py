from flask import Flask, request, jsonify
from transformers import GPT2LMHeadModel, GPT2Tokenizer

app = Flask(__name__)

# Załaduj model i tokenizer
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')
model = GPT2LMHeadModel.from_pretrained('gpt2')

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json()
    user_input = data.get("input")
    inputs = tokenizer(user_input, return_tensors="pt")
    outputs = model.generate(inputs.input_ids, max_length=150)
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return jsonify({"response": response})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5100)