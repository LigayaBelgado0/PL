# Belgado_PL - Multi-Language Lexical Analyzer Using Flex

## 📚 Project Overview

This program is a lexical analyzer written in **Flex** that supports source code tokenization for **C**, **Java**, and **Python**. It dynamically applies language-specific token rules and outputs categorized tokens such as keywords, identifiers, literals, and more.

---

## ✨ Features

- **Multi-language support**: Handles C, Java, and Python source files.
- **Dynamic language selection**: Choose language at runtime via command-line input.
- **Token classification**:
  - Keywords
  - Identifiers
  - Operators
  - Literals (strings, numbers, chars)
  - Delimiters
  - Comments
- **Language-specific syntax handling**:
  - Handles nested/multiline comments (C/Java)
  - Python indentation handling
  - Unterminated string/error detection

---

## 🖥️ System Requirements

### Software
- Windows OS
- [Flex](https://github.com/westes/flex) (latest version)
- GCC or compatible C compiler
- Command-line terminal (e.g., CMD, Git Bash)

### Hardware
- Intel Core i5 or higher
- 8 GB RAM

---

## 🛠️ Installation & Compilation

1. Open terminal in project folder.
2. Generate `.c` files from Flex source:
   ```bash
   flex -o c_lexer.c c_lexer.l
   flex -o j_lexer.c j_lexer.l
   flex -o py_lexer.c py_lexer.l
   ```
3. Compile all files:
   ```bash
   gcc main.c c_lexer.c j_lexer.c py_lexer.c -o mylexer.exe
   ```

---

## ▶️ Usage

1. Run the analyzer:
   ```bash
   mylexer.exe
   ```
2. Select the programming language.
3. Enter your source code line by line.
4. Type `END` or `end` on a new line to stop input and display tokens.

---

## 🧪 Example Input

```c
int main() {
    printf("Hello, World!");
    return 0;
}
```

---

## 🎥 Demo

Watch the demo here: [YouTube Demo](https://youtu.be/UDqwpSSPLxU?si=6xUcyvYZKbzyNp07)

---

## 🛡️ Error Handling

- Invalid/unrecognized characters
- Unterminated string literals
- Mixed tab/space in Python
- Long identifiers/numbers
- Nested comments

---

## 🔮 Recommendations

- Add support for more languages (e.g., JavaScript, PHP, Rust)
- Create a GUI with tools like **Flask** or **Streamlit**
- Visualize tokens and syntax tree in real-time
-  User can upload file


---

## 📚 References

- [Flex Manual](https://gothub.dev.projectsegfau.lt/westes/flex)
- [GCC Documentation](https://gcc.gnu.org/onlinedocs/)
- [YouTube: Lexical Analyzer in Flex](https://www.youtube.com/watch?v=LpVufkH4gog)

---

## 👩‍💻 Author

**Ruby Joy Belgado**  
BSCS 3A  
Instructor: Ms. Clarexe Gulane
