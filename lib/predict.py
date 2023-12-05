from flask import Flask, request, render_template
import pandas as pd
from sklearn import model_selection
from sklearn.ensemble import GradientBoostingClassifier
from flask import jsonify
from flask_cors import CORS


app = Flask(__name__)
CORS(app)

@app.route('/', methods=['POST', 'GET'])
def predict():
    if request.method == 'POST':
        # Load and preprocess the data
        data = pd.read_csv('lib\diabetes.csv')
        matrix = data.values
        X = matrix[:, 0:8]
        Y = matrix[:, 8]
        X_train, X_test, Y_train, Y_test = model_selection.train_test_split(X, Y, test_size=0.3, random_state=42)

        # Train the model
        model = GradientBoostingClassifier()
        model.fit(X_train, Y_train)

        # Parse JSON data from Flutter app
        json_data = request.get_json()
        children = json_data['children']
        glucose = json_data['glucose']
        bp = json_data['bp']
        st = json_data['st']
        insulin = json_data['insulin']
        bmi = json_data['bmi']
        dpf = json_data['dpf']
        age = json_data['age']

        # Make a prediction
        symptoms = [[children, glucose, bp, st, insulin, bmi, float(dpf), age]]
        condition = model.predict(symptoms)

        return jsonify({'outcome': str(condition[0])})

    else:
        return "This is the Predictor server response"

if __name__ == '__main__':
    app.run(debug=True)
