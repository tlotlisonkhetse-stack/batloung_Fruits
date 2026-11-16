const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: Number(process.env.DB_PORT) || 3307,

    waitForConnections: true,
    connectionLimit: 1,
    maxIdle: 1,
    idleTimeout: 10000,
    queueLimit: 0
});

module.exports = pool;