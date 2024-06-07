const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const neo4j = require('neo4j-driver');

const app = express();
const port = 3000;

// Cập nhật kết nối tới Neo4j
const driver = neo4j.driver(
    'bolt://localhost:7687/',
    neo4j.auth.basic('neo4j', 'Letmesee')  // thay 'your_password' bằng mật khẩu của bạn
);

// Thêm phần kiểm tra kết nối
async function checkNeo4jConnection() {
    const session = driver.session({ database: 'neo4j' });
    try {
        await session.run('RETURN 1');
        return true;
    } catch (error) {
        console.error('Neo4j connection error:', error);
        return false;
    } finally {
        await session.close();
    }
}

app.use(bodyParser.json());

app.get('/check-connection', async (req, res) => {
    const connected = await checkNeo4jConnection();
    if (connected) {
        res.status(200).send('Connected to Neo4j successfully');
    } else {
        res.status(500).send('Failed to connect to Neo4j');
    }
});

app.post('/register', async (req, res) => {
    const { username, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    try {
        const session = driver.session({ database: 'neo4j' });
        await session.run(
            'CREATE (u:User {username: $username, password: $password})',
            { username, password: hashedPassword }
        );
        await session.close();
        res.status(201).send('User registered successfully');
    } catch (error) {
        res.status(500).send('Error registering user');
    }
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        const session = driver.session({ database: 'neo4j' });
        const result = await session.run(
            'MATCH (u:User {username: $username}) RETURN u',
            { username }
        );
        await session.close();

        if (result.records.length === 0) {
            return res.status(404).send('User not found');
        }

        const user = result.records[0].get('u').properties;
        const validPassword = await bcrypt.compare(password, user.password);

        if (!validPassword) {
            return res.status(401).send('Invalid password');
        }

        const token = jwt.sign({ username: user.username }, 'your_jwt_secret', { expiresIn: '1h' });
        res.status(200).json({ token });
    } catch (error) {
        console.error('Error during login:', error); // Thêm log chi tiết lỗi
        res.status(500).send('Error logging in');
    }
});



app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
