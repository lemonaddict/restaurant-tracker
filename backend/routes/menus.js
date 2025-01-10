const express = require('express');
const { recommendMenu, unrecommendMenu, getAllMenus } = require('../controllers/menuController');
const { authenticateJWT } = require('../middleware/authenticateJWT.js'); // The middleware to authenticate JWT

const router = express.Router();

router.get('/', authenticateJWT, getAllMenus)

router.put('/:menu_id/recommend', authenticateJWT, recommendMenu);

router.put('/:menu_id/unrecommend', authenticateJWT, unrecommendMenu)

module.exports = router;