// routes/reservations.js
const express = require('express');
const { Reservation } = require('../models'); // Assuming your models are in ../models
const { authenticateJWT } = require('../middleware/authenticateJWT.js'); // The middleware to authenticate JWT
const { authMiddleware } = require('../middleware/authMiddleware.js')
const { createReservation, updateReservationStatus, updateReservationDeposit, cancelReservationbyUser, cancelReservationbyMod } = require('../controllers/reservationController');


const router = express.Router();

// Route to get all reservations for the current logged-in user
router.get('/my-reservations', authenticateJWT, async (req, res) => {
  try {
    // Fetch reservations made by the logged-in user (based on user_id from the token)
    const userId = req.user.user_id;  // user_id will be extracted from the token (as set in the authenticateJWT middleware)

    // Query reservations for the logged-in user
    const reservations = await Reservation.findAll({
      where: {
        user_id: userId,  // Ensure only reservations of the logged-in user are returned
      },
    });

    // If no reservations found
    if (!reservations || reservations.length === 0) {
      return res.status(404).json({ message: 'No reservations found.' });
    }

    // Return reservations
    res.status(200).json(reservations);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving reservations' });
  }
});

router.post('/create-new-reservation', authenticateJWT, createReservation)

router.put('/:reservation_id/status', authenticateJWT, updateReservationStatus);

router.put('/:reservation_id/deposit', authenticateJWT, updateReservationDeposit);

router.put('/:reservation_id/cancel-by-user', authenticateJWT, cancelReservationbyUser);

router.put('/:reservation_id/cancel-by-mod', authenticateJWT, cancelReservationbyMod);


module.exports = router;
