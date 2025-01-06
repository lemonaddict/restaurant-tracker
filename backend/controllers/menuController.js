const { Menu } = require('../models');

const recommendMenu = async (req, res) => {
  const { menu_id } = req.params;

  try {
    // Find the menu item by ID
    const menu = await Menu.findByPk(menu_id);
    if (!menu) {
      return res.status(404).json({ error: 'Menu item not found.' });
    }

    // Update the recommended value to true (1)
    menu.recommended = true;
    await menu.save();

    return res.status(200).json({
      message: 'Menu item recommended successfully.',
      menu,
    });
  } catch (error) {
    console.error('Error recommending menu item:', error);
    return res.status(500).json({ error: 'Failed to recommend menu item.' });
  }
};

const unrecommendMenu = async (req, res) => {
  const { menu_id } = req.params;

  try {
    // Find the menu item by ID
    const menu = await Menu.findByPk(menu_id);
    if (!menu) {
      return res.status(404).json({ error: 'Menu item not found.' });
    }

    // Update the recommended value to true (1)
    menu.recommended = false;
    await menu.save();

    return res.status(200).json({
      message: 'Menu item unrecommended successfully.',
      menu,
    });
  } catch (error) {
    console.error('Error unrecommending menu item:', error);
    return res.status(500).json({ error: 'Failed to unrecommend menu item.' });
  }
};

module.exports = { recommendMenu, unrecommendMenu };