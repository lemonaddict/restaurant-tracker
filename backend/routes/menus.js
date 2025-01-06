const express = require('express');
const { recommendMenu, unrecommendMenu } = require('../controllers/menuController');
const { authenticateJWT } = require('../middleware/authenticateJWT.js'); // The middleware to authenticate JWT

const router = express.Router();

// Route to recommend a menu item
router.put('/:menu_id/recommend', authenticateJWT, recommendMenu);

router.put('/:menu_id/unrecommend', authenticateJWT, unrecommendMenu)

module.exports = router;