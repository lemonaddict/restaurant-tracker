// routes/user.js
const express = require('express');
const bcrypt = require('bcryptjs');
const { User } = require('../models');
const authenticateToken = require('../middleware/auth'); // JWT middleware
const { regulateTcoin } = require('../controllers/userController'); // Middleware for authentication

const router = express.Router();

// Update user profile (PUT /api/users/me)
router.put('/me', authenticateToken, async (req, res) => {
  const { name, email, telephone_number, password } = req.body;
  const userId = req.user.user_id;  // This comes from the JWT token

  try {
    // Find the current user
    const user = await User.findOne({ where: { user_id: userId } });

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Check if the email is already taken by another user (if a new email is provided)
    if (email && email !== user.email) {
      const existingUser = await User.findOne({ where: { email } });
      if (existingUser) {
        return res.status(400).json({ message: 'Email is already taken' });
      }
    }

    // Hash the new password if it's provided
    let hashedPassword = user.password; // Default to the current password if not updated
    if (password) {
      hashedPassword = await bcrypt.hash(password, 10); // Hash the new password
    }

    // Update the user fields with new data
    const updatedUser = await user.update({
      name: name || user.name, // Only update if a new value is provided
      email: email || user.email,
      telephone_number: telephone_number || user.telephone_number,
      password: hashedPassword, // Updated password if provided
    });

    res.status(200).json({
      message: 'Profile updated successfully',
      user: {
        name: updatedUser.name,
        email: updatedUser.email,
        telephone_number: updatedUser.telephone_number,
      },
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error });
  }
});

router.put('/tcoin', authenticateToken, regulateTcoin);


module.exports = router;
