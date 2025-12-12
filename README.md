# 🧮 Scientific Calculator - Flex & Bison

A powerful command-line scientific calculator built using **Flex** (Lexical Analyzer) and **Bison** (Parser Generator) for a Compiler Design course project.

## ✨ Features

### Basic Operations
- ➕ Addition (`+`)
- ➖ Subtraction (`-`)
- ✖️ Multiplication (`*`)
- ➗ Division (`/`)
- 🔢 Power/Exponentiation (`^`)

### Trigonometric Functions
- `sin(x)` - Sine
- `cos(x)` - Cosine
- `tan(x)` - Tangent
- `cot(x)` - Cotangent

*All angles are in degrees*

### Logarithmic Functions
- `log(x)` - Logarithm base 10
- `ln(x)` - Natural logarithm (base e)

### Root Functions
- `sqrt(x)` - Square root
- `root(x, n)` - Nth root of x
- Example: `root(8, 3)` = cube root of 8 = 2

### Other Functions
- `abs(x)` or `|x|` - Absolute value
- `exp10(x)` - 10 raised to the power of x (10^x)

### Additional Features
- ✅ Decimal number support
- ✅ Parentheses for grouping operations
- ✅ Operator precedence (follows standard mathematical rules)
- ✅ Error handling and recovery
- ✅ Continuous input (doesn't exit on errors)

## 📋 Prerequisites

### Linux/Ubuntu
```bash
sudo apt-get update
sudo apt-get install flex bison gcc
```

### Windows (WSL - Recommended)
1. Install WSL:
   ```powershell
   wsl --install
   ```
2. Open Ubuntu and install tools:
   ```bash
   sudo apt-get update
   sudo apt-get install flex bison gcc
   ```

### macOS
```bash
brew install flex bison gcc
```

## 🚀 Installation & Usage

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/calculator-flex-bison.git
cd calculator-flex-bison
```

### 2. Compile the Project
```bash
bison -d calculator.y
flex calculator.l
gcc lex.yy.c calculator.tab.c -o calculator -lm
```

### 3. Run the Calculator
```bash
./calculator
```

For Windows (if not using WSL):
```cmd
calculator.exe
```

## 📖 Usage Examples

```
Enter expression (Ctrl+Z to end): 3+5*2
Result: 13.00

Enter expression (Ctrl+Z to end): sin(45)
Result: 0.71

Enter expression (Ctrl+Z to end): sqrt(16)
Result: 4.00

Enter expression (Ctrl+Z to end): 2^10
Result: 1024.00

Enter expression (Ctrl+Z to end): log(100)
Result: 2.00

Enter expression (Ctrl+Z to end): root(27, 3)
Result: 3.00

Enter expression (Ctrl+Z to end): abs(-15)
Result: 15.00

Enter expression (Ctrl+Z to end): |-15|
Result: 15.00

Enter expression (Ctrl+Z to end): (3+5)*2
Result: 16.00

Enter expression (Ctrl+Z to end): exp10(3)
Result: 1000.00
```

## 📁 Project Structure

```
calculator-flex-bison/
├── calculator.l          # Flex lexical analyzer
├── calculator.y          # Bison parser
├── README.md            # Project documentation
├── lex.yy.c             # Generated lexer (auto-generated)
├── calculator.tab.c     # Generated parser (auto-generated)
├── calculator.tab.h     # Generated header (auto-generated)
└── calculator           # Compiled executable (after build)
```

## 🔧 How It Works

### Flex (Lexical Analysis)
The `calculator.l` file defines patterns to recognize:
- Numbers (integers and decimals)
- Operators (`+`, `-`, `*`, `/`, `^`)
- Functions (`sin`, `cos`, `log`, etc.)
- Parentheses and special characters

**Example:** Input `sin(45)` is tokenized as:
```
SIN → LPAREN → NUMBER(45) → RPAREN
```

### Bison (Parsing & Evaluation)
The `calculator.y` file defines grammar rules and performs calculations:
- Applies operator precedence (multiplication before addition)
- Evaluates expressions recursively
- Handles errors gracefully

**Example:** Expression `3+5*2` is parsed as:
```
3 + (5 * 2) = 3 + 10 = 13
```

## 🎯 Operator Precedence

From highest to lowest priority:
1. Functions: `sin()`, `cos()`, `sqrt()`, etc.
2. Power: `^` (right-associative)
3. Unary minus: `-x`
4. Multiplication & Division: `*`, `/`
5. Addition & Subtraction: `+`, `-`
6. Absolute value: `|x|`

## ⚠️ Error Handling

The calculator handles various errors gracefully:
- **Division by zero**: `10/0` → "Invalid input!"
- **Invalid syntax**: `5++3` → "Invalid input!"
- **Domain errors**: `sqrt(-4)` → "Invalid input!"
- **Logarithm errors**: `log(-1)` → "Invalid input!"

After an error, the calculator continues running and prompts for new input.

## 🛑 Exiting the Calculator

- **Linux/Mac/WSL**: Press `Ctrl+D`
- **Windows CMD**: Press `Ctrl+Z` then Enter

## 🧪 Test Cases

```bash
# Basic arithmetic
3+5*2          → 13.00
(3+5)*2        → 16.00
10/2           → 5.00

# Trigonometry
sin(30)        → 0.50
cos(60)        → 0.50
tan(45)        → 1.00

# Powers and roots
2^10           → 1024.00
sqrt(25)       → 5.00
root(8,3)      → 2.00

# Logarithms
log(1000)      → 3.00
ln(2.718)      → 1.00

# Complex expressions
sin(30)+cos(60) → 1.00
2^3*5           → 40.00
sqrt(16)+2^3    → 12.00
```

## 🐛 Troubleshooting

### "command not found: bison" or "command not found: flex"
- Make sure Flex and Bison are installed
- On Windows, use WSL or install MinGW

### "undefined reference to `sin`" or linking errors
- Make sure to include `-lm` flag when compiling
- Correct: `gcc lex.yy.c calculator.tab.c -o calculator -lm`

### Calculator exits immediately
- Check if you're pressing Ctrl+D or Ctrl+Z accidentally
- Make sure to press Enter after typing each expression

## 📚 Learning Resources

- [Flex Documentation](https://github.com/westes/flex)
- [Bison Documentation](https://www.gnu.org/software/bison/manual/)
- [Compiler Design Concepts](https://en.wikipedia.org/wiki/Compiler)

## 👨‍💻 Author

**Syed Ahmad Galib**
- GitHub: [@galib-272](https://github.com/galib-272)
- Course: Compiler Design
- Department: Computer Science & Engineering
- University: Daffodil International University

## 📝 License

This project is created for educational purposes as part of a Compiler Design course.

## 🤝 Contributing

Feel free to fork this project and submit pull requests for improvements!

## ⭐ Acknowledgments

- Special thanks to the Compiler Design course instructor
- Flex and Bison communities for excellent documentation
- Open source contributors

---

**Made with ❤️ using Flex & Bison**

*If you found this project helpful, please consider giving it a ⭐ on GitHub!*
