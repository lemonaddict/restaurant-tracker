// middleware/authMiddleware.js
const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  // Retrieve the token from the 'Authorization' header
  const token = req.header('Authorization')?.replace('Bearer ', '');

  if (!token) {
    return res.status(401).json({ message: 'No token, authorization denied' });
  }

  try {
    // Verify the token using the secret key and decode it
    const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);
    
    // Attach the user data (decoded token) to the request object
    req.user = decoded;  // Make sure this contains the user ID from the token
    next();  // Proceed to the next middleware/handler
  } catch (err) {
    res.status(400).json({ message: 'Invalid or expired token' });
  }
};

module.exports = authMiddleware;
