const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('../utils/jwt'); // Import JWT utility
const { User } = require('../models'); // Import User model
const router = express.Router();

// Signup Route
router.post('/signup', async (req, res) => {
  const { name, email, telephone_number, password } = req.body;

  try {
    // Check if the email is already registered
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ message: 'Email already in use' });
    }

    // Create a new user
    const newUser = await User.create({ name, email, telephone_number, password });

    // Generate JWT token
    const token = jwt.generateToken(newUser);

    // Send response with token
    res.status(201).json({
      message: 'User created successfully',
      token,
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error });
  }
});

// Login Route
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // Find user by email
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    // Compare password with stored hash
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.generateToken(user);

    // Send response with token
    res.status(200).json({
      message: 'Login successful',
      token,
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error });
  }
});

// Logout Route (In case of JWT, it's client-side handling)
router.post('/logout', (req, res) => {
  res.status(200).json({ message: 'Logout successful' });
});

module.exports = router;
