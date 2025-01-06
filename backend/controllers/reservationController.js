// controllers/reservationController.js

const { Reservation, Menus_Preorders, Menu } = require('../models'); // Adjust paths if necessary

async function createReservation(req, res) {
  const { date_time, table_id, menu_ids } = req.body;
  const user_id = req.user.user_id; // Get the user ID from the authenticated JWT token
  console.log(user_id)
  try {
    // Create a new reservation
    const reservation = await Reservation.create({
      date_time,
      table_id,   // Add table_id
      user_id,
      status: 'pending',  // Default status
      cancelled_by: null,
      deposited: false,  // Default deposited status
    });

    // Map the menu IDs to create preorders
    const menuPreorders = menu_ids.map(menu_id => ({
      reservation_id: reservation.reservation_id,
      menu_id: menu_id,
      quantity: 1,  // Default quantity (you can adjust it)
    }));

    // Insert the preorder records
    await Menus_Preorders.bulkCreate(menuPreorders);

    res.status(201).json({ message: 'Reservation created successfully!', reservation });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error creating reservation.' });
  }
}

async function updateReservationStatus(req, res) {
  try {
    const { reservation_id } = req.params; // Extract reservation ID from URL
    const { status } = req.body; // New status from request body
    const validStatuses = ['pending', 'cancelled', 'completed'];

    // Validate status
    if (!validStatuses.includes(status)) {
      return res.status(400).json({ error: 'Invalid status value.' });
    }

    // Find the reservation
    const reservation = await Reservation.findByPk(reservation_id);
    if (!reservation) {
      return res.status(404).json({ error: 'Reservation not found.' });
    }

    // Update the reservation status
    reservation.status = status;
    await reservation.save();

    return res.status(200).json({
      message: 'Reservation status updated successfully.',
      reservation,
    });
  } catch (error) {
    console.error('Error updating reservation status:', error);
    return res.status(500).json({ error: 'Failed to update reservation status.' });
  }
};

const updateReservationDeposit = async (req, res) => {
  try {
    const { reservation_id } = req.params; // Extract reservation ID from URL
    const { deposited } = req.body; // New deposit value from request body

    // Validate input: deposited must be a boolean
    if (typeof deposited !== 'boolean') {
      return res.status(400).json({ error: 'Deposited value must be true or false.' });
    }

    // Find the reservation
    const reservation = await Reservation.findByPk(reservation_id);
    if (!reservation) {
      return res.status(404).json({ error: 'Reservation not found.' });
    }

    // Update the deposited field
    reservation.deposited = deposited;
    await reservation.save();

    return res.status(200).json({
      message: 'Reservation deposit value updated successfully.',
      reservation,
    });
  } catch (error) {
    console.error('Error updating reservation deposit value:', error);
    return res.status(500).json({ error: 'Failed to update reservation deposit value.' });
  }
};

const cancelReservationbyUser = async (req, res) => {
  const { reservation_id } = req.params;

  try {
    // Find the reservation
    const reservation = await Reservation.findByPk(reservation_id);
    if (!reservation) {
      return res.status(404).json({ error: 'Reservation not found.' });
    }

    // Update the reservation status to 'cancel' and set the cancelled_by field
    reservation.status = 'cancelled';
    reservation.cancelled_by = 'user';
    await reservation.save();

    return res.status(200).json({
      message: 'Reservation cancelled by user successfully.',
      reservation,
    });
  } catch (error) {
    console.error('Error cancelling reservation:', error);
    return res.status(500).json({ error: 'Failed to cancel reservation.' });
  }
};

const cancelReservationbyMod = async (req, res) => {
  const { reservation_id } = req.params;

  try {
    // Find the reservation
    const reservation = await Reservation.findByPk(reservation_id);
    if (!reservation) {
      return res.status(404).json({ error: 'Reservation not found.' });
    }

    // Update the reservation status to 'cancel' and set the cancelled_by field
    reservation.status = 'cancelled';
    reservation.cancelled_by = 'moderator';
    await reservation.save();

    return res.status(200).json({
      message: 'Reservation cancelled by mod successfully.',
      reservation,
    });
  } catch (error) {
    console.error('Error cancelling reservation:', error);
    return res.status(500).json({ error: 'Failed to cancel reservation.' });
  }
};

module.exports = { createReservation, updateReservationStatus, 
  updateReservationDeposit, cancelReservationbyUser, cancelReservationbyMod };
