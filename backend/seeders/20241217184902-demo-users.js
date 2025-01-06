// seeders/20240101010101-demo-user.js
const bcrypt = require('bcryptjs');

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Users', [
      {
        name: 'John Doe',
        email: 'john1@example.com',
        telephone_number: '123456789',
        password: await bcrypt.hash('password123', 10),
        t_coin: 45000,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Jane Doe',
        email: 'jane1@example.com',
        telephone_number: '987654321',
        password: await bcrypt.hash('password123', 10),
        t_coin: 45000,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Bob Smith',
        email: 'bob@example.com',
        telephone_number: '111222333',
        password: await bcrypt.hash('password123', 10),
        t_coin: 45000,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Alice Johnson',
        email: 'alice@example.com',
        telephone_number: '444555666',
        password: await bcrypt.hash('password123', 10),
        t_coin: 45000,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Charlie Brown',
        email: 'charlie@example.com',
        telephone_number: '777888999',
        password: await bcrypt.hash('password123', 10),
        t_coin: 45000,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Users', null, {});
  },
};
