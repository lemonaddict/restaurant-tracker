// seeders/20240101010103-demo-reservation.js

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Reservations', [
      {
        date_time: new Date(),
        table_id: 1,
        user_id: 1,  // Replace with an actual user_id from your Users table
        status: 'pending',
        cancelled_by: null,
        deposited: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        date_time: new Date(),
        table_id: 2,
        user_id: 2,  // Replace with an actual user_id
        status: 'completed',
        cancelled_by: null,
        deposited: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        date_time: new Date(),
        table_id: 3,
        user_id: 3,  // Replace with an actual user_id
        status: 'cancelled',
        cancelled_by: 'user',
        deposited: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        date_time: new Date(),
        table_id: 4,
        user_id: 4,  // Replace with an actual user_id
        status: 'pending',
        cancelled_by: null,
        deposited: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        date_time: new Date(),
        table_id: 5,
        user_id: 5,  // Replace with an actual user_id
        status: 'completed',
        cancelled_by: null,
        deposited: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Reservations', null, {});
  },
};
