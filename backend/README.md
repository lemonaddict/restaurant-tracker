# ResTrack Backend

This is the backend for the ResTrack application, which handles user authentication, reservations, and menu preorders.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
  - [Authentication](#authentication)
  - [Users](#users)
  - [Reservations](#reservations)
- [Database Models](#database-models)
- [Seeding the Database](#seeding-the-database)
- [License](#license)

## Installation

1. Clone the repository:
```sh
git clone https://github.com/yourusername/restrack_backend.git
cd restrack_backend
```
2. Install dependencies:
```sh
npm install
```
3. Set up your environment variables: Create a .env file in the root directory and add the following:
```
JWT_SECRET=your_jwt_secret_key
```
4. Configure the database: Update the config.json file with your database credentials.

## Configuration
Ensure you have a MySQL database set up and update the config.json file with your database credentials.
## Running the Application
1. Run the migrations to set up the database schema:
```sh
npx sequelize-cli db:migrate
```
2. Seed the database with initial data:
```sh
npx sequelize-cli db:seed:all
```
3. Start the server
```sh
npm start
```
The server will run on http://localhost:3000.
## API Endpoints
### Authentication
- Signup
  - POST /api/auth/signup
  - Request body:
  ```json
  {
  "name": "John Doe",
  "email": "john@example.com",
  "telephone_number": "123456789",
  "password": "password123"
  }
  ```
- Login
  - POST /api/auth/login
  - Request body:
  ```json
  {
  "email": "john@example.com",
  "password": "password123"
  }
  ```
### Users
- Update profile
  - PUT /api/users/me
  - Requires JWT auth
  - Request body:
  ```json
  {
  "name": "John Doe",
  "email": "john@example.com",
  "telephone_number": "123456789",
  "password": "newpassword123"
  }
  ```
- Regulate T-Coin
  - PUT /api/users/tcoin
  - Requires JWT auth
  - Request body:
  ```json
  {
  "t_coin": 30000
  }
  ```
### Reservations
- Get My Reservations
  - GET /api/reservations/my-reservations
  - Requires JWT authentication
  - Request body:
  ```json
  {
  "date_time": "2023-12-17T18:59:00Z",
  "table_id": 1,
  "menu_ids": [1, 2, 3]
  }
  ```
- Update Reservation Status
  - PUT /api/reservations/:reservation_id/status
  - Requires JWT authentication
  - Request body:
  ```json
  {
  "status": "completed"
  }
  ```
- Update Reservation Deposit
  - PUT /api/reservations/:reservation_id/deposit
  - Requires JWT authentication
  - Request body:
  ```json
  {
  "deposited": true
  }
  ```
- Cancel Reservation By User
  - PUT /api/reservations/:reservation_id/cancel-by-user
  - Requires JWT authentication
- Cancel Reservation By Mod
  - PUT /api/reservations/:reservation_id/cancel-by-mod
  - Requires JWT authentication
### Menus
- Recommend menu
  - PUT /api/menus/:menu_id/recommend
  - Requires JWT authentication
- Unrecommend menu
  - PUT /api/menus/:menu_id/unrecommend
  - Requires JWT authentication