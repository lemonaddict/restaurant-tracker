// seeders/20240101010105-demo-menu-preorder.js

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Menus_Preorders', [
      {
        reservation_id: 1,
        menu_id: 1,
        quantity: 2,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        reservation_id: 2,
        menu_id: 2,
        quantity: 1,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        reservation_id: 3,
        menu_id: 3,
        quantity: 3,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        reservation_id: 4,
        menu_id: 4,
        quantity: 2,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        reservation_id: 5,
        menu_id: 5,
        quantity: 1,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Menus_Preorders', null, {});
  },
};
