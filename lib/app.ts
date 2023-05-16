import express from 'express';
import http from 'http';
import path from 'path';
import { Client } from 'pg';

const api = express();

api.use('/', express.static(path.join(__dirname, '..', 'public')));

const server = http.createServer(api);

server.listen(3000);

console.log('dadas');

( async () => {
    const client = new Client({
        host: 'datenbank', // Network alias
        port: 5432,
        user: 'postgres',
        password: 'secret'
    });
    await client.connect();

    const  { rows } = await client.query(
        'SELECT $1::test AS message', ['Huhu']
    );

    console.log("aadsaaadsda");
    console.log(rows[0].message);

    await client.end();
})();
