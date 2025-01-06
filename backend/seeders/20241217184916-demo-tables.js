// seeders/20240101010102-demo-table.js

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Tables', [
      { table_capacity: 4, createdAt: new Date(), updatedAt: new Date() },
      { table_capacity: 2, createdAt: new Date(), updatedAt: new Date() },
      { table_capacity: 6, createdAt: new Date(), updatedAt: new Date() },
      { table_capacity: 8, createdAt: new Date(), updatedAt: new Date() },
      { table_capacity: 10, createdAt: new Date(), updatedAt: new Date() },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Tables', null, {});
  },
};
