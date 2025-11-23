# Mods CLI with Ollama - Usage Guide

## 🧠 Models Installed

- **deepseek-coder** (776 MB): Primary for coding tasks - specialized for code generation, debugging, and analysis
- **mixtral** (26 GB): Complex reasoning and architecture discussions - powerful 8x7B model
- **mistral** (4.4 GB): Lightweight general-purpose - European AI from France

## 🚀 Quick Start

### Basic Usage
```bash
# Simple query
ai "explain clean architecture"

# Pipe command output to AI
ls -la | ai "explain what these files do"

# Generate code
ai "write a Kotlin function to parse JSON"
```

### Model Selection
```bash
ai "question"              # uses deepseek-coder (default)
aicode "question"          # explicitly use deepseek-coder
aimix "question"           # use mixtral for complex reasoning
aimistral "question"       # use mistral for general tasks
```

## 💻 Coding Workflows

### Code Analysis
```bash
# Explain code
cat MyFile.kt | aiexplain

# Analyze git changes
git diff | aiexplain

# Review a specific file
cat src/main/kotlin/Service.kt | aicode "review this code for issues"
```

### Debugging
```bash
# Debug errors
cat error.log | aidebug

# Debug test failures
./gradlew test 2>&1 | aidebug

# Debug command output
kubectl logs my-pod | aidebug
```

### Code Generation
```bash
# Generate function
ai "create a Spring Boot REST controller for user management"

# Generate tests
cat src/MyClass.kt | aitest

# Generate with specific requirements
ai "write a Kotlin coroutine to fetch data from API with retry logic"
```

### Code Refactoring
```bash
# Refactor code
cat legacy-code.java | airefactor

# Refactor with specific goal
cat MyService.kt | aicode "refactor this to use dependency injection"
```

### Documentation
```bash
# Generate docs
cat MyClass.kt | aidocs

# Generate README
ls -la | ai "create a README explaining this project structure"
```

### Commit Messages
```bash
# Generate commit message from staged changes
git diff --staged | aicommit

# Generate commit message from specific changes
git diff main..feature-branch | aicommit
```

### Architecture Review
```bash
# Review architecture with powerful model
cat docs/architecture.md | aiarch

# Analyze project structure
tree -L 3 | aiarch

# System design review
cat design-doc.md | aimix "critique this design and suggest improvements"
```

## 🔧 Advanced Usage

### Multi-file Analysis
```bash
# Analyze multiple files
cat src/*.kt | aicode "find potential bugs in these files"
```

### Pipeline Integration
```bash
# Test and analyze failures
./gradlew test 2>&1 | grep FAILED | aidebug

# Analyze logs for patterns
kubectl logs -f my-app | ai "summarize errors and warnings"
```

### Interactive Mode
```bash
# Start interactive session with a model
ollama run deepseek-coder

# Or with different model
ollama run mixtral
```

## 🎯 Real-World Examples

### Example 1: Debug Kubernetes Issue
```bash
kubectl describe pod my-pod | aidebug
```

### Example 2: Review Pull Request
```bash
git diff main...feature-branch | aicode "review these changes for bugs and improvements"
```

### Example 3: Generate Spring Boot Code
```bash
ai "create a Spring Boot service with JPA repository for User entity with fields: id, email, name, createdAt"
```

### Example 4: Analyze Maven Build Failure
```bash
mvn clean install 2>&1 | aidebug
```

### Example 5: Architecture Discussion
```bash
aimix "explain microservices vs monolith trade-offs for a team of 5 engineers"
```

## 📝 Model Comparison

| Model | Best For | Speed | Quality | Size |
|-------|----------|-------|---------|------|
| deepseek-coder | Code generation, debugging, analysis | Fast | High for code | 776 MB |
| mixtral | Complex reasoning, architecture | Medium | Highest | 26 GB |
| mistral | General questions, quick tasks | Fast | Good | 4.4 GB |

## 🛠️ Direct Ollama Usage

If you want to use Ollama directly without mods:

```bash
# Interactive mode
ollama run deepseek-coder
ollama run mixtral
ollama run mistral

# One-off query
ollama run deepseek-coder "your prompt here"

# List all models
ollama list

# Remove a model
ollama rm model-name

# Update a model
ollama pull deepseek-coder:latest
```

## 💡 Tips & Tricks

1. **Use the right model**: deepseek-coder for code, mixtral for complex thinking
2. **Pipe everything**: Most commands can be piped to AI for analysis
3. **Be specific**: More context = better responses
4. **Combine tools**: Use with `grep`, `awk`, `jq` for powerful pipelines
5. **Save responses**: `ai "query" > output.txt` to save responses

## 🔍 Troubleshooting

### Ollama not running?
```bash
brew services restart ollama
```

### Slow responses?
- deepseek-coder is fastest
- mistral is good middle ground
- mixtral is powerful but slower

### Check Ollama status
```bash
ollama list
lsof -i :11434
```

## 📚 Additional Resources

- Ollama: https://ollama.com
- Mods: https://github.com/charmbracelet/mods
- Models library: https://ollama.com/library

---

**Installed on:** M4 Pro with 48GB RAM
**Location:** `~/.local/share/ollama/models/`
**Config:** `~/.zshrc` (see AI aliases section)
