const express = require('express');
const { spawn } = require('child_process');
const path = require('path');
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.static(path.join(__dirname, '../frontend')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../frontend/index.html'));
});

app.post('/calculate', (req, res) => {
    const expression = req.body.expression;
    
    const calculator = spawn('./calculator');
    
    let output = '';
    
    calculator.stdout.on('data', (data) => {
        output += data.toString();
    });
    
    calculator.on('close', (code) => {
        console.log('Backend output:', output); // Debug log
        
        // Extract ONLY the result number
        const resultMatch = output.match(/Result:\s*([-]?\d+\.?\d*)/);
        if (resultMatch) {
            res.json({ result: parseFloat(resultMatch[1]) });
        } else {
            res.json({ error: 'Invalid expression' });
        }
    });
    
    // Send expression with newline
    calculator.stdin.write(expression + '\n');
    calculator.stdin.end();
});

app.listen(port, () => {
    console.log(`Server running!`);
    console.log(`Open: http://localhost:${port}`);
});