const express = require('express');
const bodyParser = require('body-parser');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/users')
const reservationRoutes = require('./routes/reservations');
const menuRoutes = require('./routes/menus')

const app = express();
const PORT = 3000;

app.use(bodyParser.json()); // Parse JSON bodies
app.use('/api/auth', authRoutes); // Use auth routes for login, signup, logout
app.use('/api/users', userRoutes);
app.use('/api/reservations', reservationRoutes);
app.use('/api/menus', menuRoutes)



app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
