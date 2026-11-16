const mysql = require('mysql2/promise');
require('dotenv').config();

const config = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: Number(process.env.DB_PORT) || 3307
};

// Allow at most 2 queries at the same time inside one server instance
let active = 0;
const waiting = [];

function acquire() {
    return new Promise(resolve => {
        if (active < 2) {
            active++;
            resolve();
        } else {
            waiting.push(resolve);
        }
    });
}

function release() {
    const next = waiting.shift();
    if (next) next();
    else active--;
}

async function run(method, sql, params) {
    await acquire();
    try {
        for (let attempt = 0; attempt < 6; attempt++) {
            let conn;
            try {
                conn = await mysql.createConnection(config);
                return await conn[method](sql, params);
            } catch (err) {
                const full =
                    err.errno === 1226 ||
                    /max_user_connections/.test(err.message || '');
                if (!full || attempt === 5) throw err;
                await new Promise(r => setTimeout(r, 300 * (attempt + 1)));
            } finally {
                if (conn) await conn.end().catch(() => {});
            }
        }
    } finally {
        release();
    }
}

module.exports = {
    query: (sql, params) => run('query', sql, params),
    execute: (sql, params) => run('execute', sql, params)
};