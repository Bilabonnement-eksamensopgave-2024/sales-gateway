# Sales-gateway

## Overview
This API Gateway acts as an intermediary for various microservices, consolidating multiple endpoints into a unified interface. It is built using Flask and supports secure communication with the microservices for managing subscriptions, cars, and user authentication. 

---

## Features
- Acts as a centralized API gateway for microservices:
  - Subscriptions
  - Cars
  - User Authentication
- Implements role-based access control (`sales` role required).
- Handles multiple HTTP methods (GET, POST, PATCH, DELETE).
- Includes Swagger documentation for API endpoints.
- Uses `.env` for configurable environment variables.
- Integrated health checks and error handling for unmatched routes.

---

## Architecture
### Diagram

```mermaid
graph LR
    A[Browser] --> B[Sales Gateway]
    B --> C[Abonnement Microservice]
    C --> D[Abonnement Database]

