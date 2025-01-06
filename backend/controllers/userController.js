const { User } = require('../models');

// Controller to regulate t_coin for the logged-in user
const regulateTcoin = async (req, res) => {
  try {
    const { t_coin } = req.body; // Desired t_coin value
    const userId = req.user.user_id; // Extract user ID from the authenticated user

    // Input validation: t_coin must be a number and a multiple of 15000
    if (typeof t_coin !== 'number' || t_coin % 15000 !== 0) {
      return res.status(400).json({ 
        error: 't_coin must be a number and a multiple of 15000.' 
      });
    }

    // Find the user
    const user = await User.findByPk(userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found.' });
    }

    // Update the t_coin field
    user.t_coin = t_coin;
    await user.save();

    return res.status(200).json({
      message: 't_coin successfully updated.',
      user: {
        user_id: user.user_id,
        name: user.name,
        email: user.email,
        t_coin: user.t_coin,
      },
    });
  } catch (error) {
    console.error('Error regulating t_coin:', error);
    return res.status(500).json({ error: 'Failed to update t_coin.' });
  }
};

module.exports = { regulateTcoin };
