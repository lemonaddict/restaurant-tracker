// seeders/20240101010104-demo-menu.js

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Menus', [
      {
        name: 'Pizza Margherita',
        category: 'food',
        price: 10.0,
        recommended: true,
        image: 'https://example.com/images/pizza-margherita.jpg',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Spaghetti Bolognese',
        category: 'food',
        price: 15.0,
        recommended: false,
        image: 'https://example.com/images/spaghetti-bolognese.jpg',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Coca Cola',
        category: 'beverage',
        price: 5.0,
        recommended: true,
        image: 'https://example.com/images/coca-cola.jpg',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Lemonade',
        category: 'beverage',
        price: 7.5,
        recommended: false,
        image: 'https://example.com/images/lemonade.jpg',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: 'Caesar Salad',
        category: 'food',
        price: 12.0,
        recommended: true,
        image: 'https://example.com/images/caesar-salad.jpg',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Menus', null, {});
  },
};
