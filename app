from flask import Flask, jsonify, request, make_response
import requests
import os
from flasgger import swag_from
from dotenv import load_dotenv
from swagger.config import init_swagger


app = Flask(__name__)

# Load environment variables from .env file
load_dotenv()

# MICROSERVICES:
MICROSERVICES = {
    "abonnement": os.getenv("ABONNEMENT_MICROSERVICE_URL", "http://localhost:5002"),
    "car": os.getenv("CAR_MICROSERVICE_URL", "http://localhost:5004"),
    "user": os.getenv("LOGIN_MICROSERVICE_URL", "http://localhost:5005"),
}

# Initialize Swagger
init_swagger(app)

# ----------------------------------------------------- GET /subscriptions
@app.route('/subscriptions', methods=['GET']) 
def get_subscriptions(): 
    response = requests.get(f"{MICROSERVICES['abonnement']}/subscriptions") 
    if response.status_code == 200: 
        return jsonify(response.json()), 200 
    else: 
        data = response.json
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code

# ----------------------------------------------------- GET /subscriptions/id
@app.route('/subscriptions/<int:id>', methods=['GET'])
def get_subscription(id):    
    response = requests.get(f"{MICROSERVICES['abonnement']}/subscriptions/{id}") 
    if response.status_code == 200: 
        return jsonify(response.json()), 200 
    else: 
        data = response.json
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code
    
# ----------------------------------------------------- GET /subscriptions/id/car TODO
@app.route('/subscriptions/<int:id>/car', methods=['GET'])
def get_subscription_car_info(id):
    response = requests.get(f"{MICROSERVICES['abonnement']}/subscriptions/{id}/car") 
    if response.status_code == 200: 
        return jsonify(response.json()), 200 
    else: 
        data = response.json
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code
    
# ----------------------------------------------------- POST /subscriptions
@app.route('/subscriptions', methods=['POST'])
def post_subscription():
    response = requests.get(f"{MICROSERVICES['abonnement']}/subscriptions") 
    if response.status_code == 200: 
        return jsonify(response.json()), 200 
    else: 
        data = response.json
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code
    
# ----------------------------------------------------- PATCH /subscriptions/id
@app.route('/subscriptions/<int:id>', methods=['PATCH'])
def patch_subscription(id): 
    response = requests.get(f"{MICROSERVICES['abonnement']}/subscriptions/{id}") 
    if response.status_code == 200: 
        return jsonify(response.json()), 200 
    else: 
        data = response.json
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code
    
# ----------------------------------------------------- GET /car
@app.route('/cars/available', methods=['GET'])
def get_cars(id): 
    response = requests.get(f"{MICROSERVICES['car']}/cars/available") 
    if response.status_code == 200: 
        return jsonify(response.json()), 200 
    else: 
        data = response.json
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code
    
# ----------------------------------------------------- DELETE /subscriptions/id
@app.route('/subscriptions/<int:id>', methods=['DELETE'])
def delete_subscription(id):    
    response = requests.get(f"{MICROSERVICES['abonnement']}/subscriptions/{id}") 
    if response.status_code == 200: 
        return jsonify(response.json()), 200 
    else: 
        data = response.json
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code
    
# ----------------------------------------------------- POST /login
@app.route('/login', methods=['POST'])
def login():
    response = requests.post(f"{MICROSERVICES['user']}/login")
    if response.status_code == 200:
        return jsonify(response.json()), 200
    else:
        data = response.json()
        return jsonify({
            "error": "Failed to fetch from microservice",
            "data_returned_from_microservice": data
        }), response.status_code

# ----------------------------------------------------- GET /health
@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy"}), 200

# ----------------------------------------------------- Catch-all route for unmatched endpoints 
@app.errorhandler(404)
def page_not_found_404(e):
    return jsonify({"message": "Endpoint does not exist"})

@app.errorhandler(405)
def page_not_found_405(e):
    return jsonify({"message": "Method not allowed - double check the method you are using"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5001)))
