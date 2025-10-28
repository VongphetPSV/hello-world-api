#!/bin/bash
set -e

echo "🚀 3-Agent Autonomous Development System - Setup"
echo "================================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "ℹ $1"
}

# Check prerequisites
echo "📋 Checking prerequisites..."
echo ""

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    print_success "Node.js installed: $NODE_VERSION"
else
    print_error "Node.js not found. Please install Node.js 18+ first."
    exit 1
fi

# Check Git
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    print_success "Git installed: $GIT_VERSION"
else
    print_error "Git not found. Please install Git first."
    exit 1
fi

# Check GitHub CLI
if command -v gh &> /dev/null; then
    GH_VERSION=$(gh --version | head -n 1)
    print_success "GitHub CLI installed: $GH_VERSION"
else
    print_warning "GitHub CLI not found. You'll need to configure secrets manually."
fi

echo ""
echo "📁 Creating project structure..."
echo ""

# Create directories
mkdir -p .github/workflows
mkdir -p plans
mkdir -p qa-reports
mkdir -p src
mkdir -p tests

print_success "Directories created"

# Copy workflow files
echo ""
echo "🤖 Installing agent workflows..."
echo ""

if [ -f "agent-1-architect.yml" ]; then
    cp agent-1-architect.yml .github/workflows/
    print_success "Agent 1 (Architect) workflow installed"
else
    print_error "agent-1-architect.yml not found in current directory"
    exit 1
fi

if [ -f "agent-2-engineer.yml" ]; then
    cp agent-2-engineer.yml .github/workflows/
    print_success "Agent 2 (Engineer) workflow installed"
else
    print_error "agent-2-engineer.yml not found in current directory"
    exit 1
fi

if [ -f "agent-3-qa.yml" ]; then
    cp agent-3-qa.yml .github/workflows/
    print_success "Agent 3 (QA) workflow installed"
else
    print_error "agent-3-qa.yml not found in current directory"
    exit 1
fi

# Initialize package.json if not exists
if [ ! -f "package.json" ]; then
    echo ""
    echo "📦 Creating package.json..."
    cat > package.json << 'EOF'
{
  "name": "hello-world-api",
  "version": "1.0.0",
  "description": "3-Agent autonomous development demo",
  "main": "src/index.js",
  "scripts": {
    "start": "node src/index.js",
    "dev": "nodemon src/index.js",
    "test": "jest --coverage",
    "test:watch": "jest --watch",
    "lint": "eslint src/ tests/"
  },
  "keywords": ["api", "autonomous", "agents"],
  "license": "MIT",
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "supertest": "^6.3.3",
    "eslint": "^8.55.0",
    "nodemon": "^3.0.2"
  },
  "jest": {
    "testEnvironment": "node",
    "coverageDirectory": "coverage",
    "collectCoverageFrom": [
      "src/**/*.js",
      "!src/**/*.test.js"
    ],
    "coverageThreshold": {
      "global": {
        "branches": 90,
        "functions": 90,
        "lines": 90,
        "statements": 90
      }
    }
  }
}
EOF
    print_success "package.json created"
else
    print_info "package.json already exists, skipping"
fi

# Create .gitignore if not exists
if [ ! -f ".gitignore" ]; then
    echo ""
    echo "🔒 Creating .gitignore..."
    cat > .gitignore << 'EOF'
node_modules/
coverage/
.env
*.log
.DS_Store
.idea/
.vscode/
dist/
build/
EOF
    print_success ".gitignore created"
fi

# Create README if not exists
if [ ! -f "README.md" ]; then
    echo ""
    echo "📖 Creating README.md..."
    cat > README.md << 'EOF'
# Hello World API

Autonomous development demo using 3-agent system.

## Quick Start

```bash
npm install
npm start
# Visit: http://localhost:3000/hello
```

## Development Process

1. Create GitHub Issue with label "agent-develop"
2. Agents automatically plan, implement, and validate
3. Review PR and merge

## Agents

- **Agent 1 (Architect)**: Plans the feature
- **Agent 2 (Engineer)**: Implements the code
- **Agent 3 (QA)**: Validates quality

## Setup Status

- [x] Project initialized
- [ ] First feature deployed

## Next Steps

1. Push to GitHub: `git push origin main`
2. Configure secrets (see SETUP.md)
3. Create your first issue!
EOF
    print_success "README.md created"
fi

# Git initialization
echo ""
echo "🔧 Git configuration..."
echo ""

if [ ! -d ".git" ]; then
    git init
    print_success "Git repository initialized"
else
    print_info "Git repository already initialized"
fi

# Add and commit
git add .
if git diff --cached --quiet; then
    print_info "No changes to commit"
else
    git commit -m "🚀 Setup 3-agent autonomous development system

- Agent 1 (Architect): Planning workflow
- Agent 2 (Engineer): Implementation workflow
- Agent 3 (QA): Validation workflow
- Project structure initialized
- Configuration files created"
    print_success "Initial commit created"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Create GitHub repository:"
echo "   gh repo create hello-world-api --public --source=. --push"
echo ""
echo "2. Configure secrets in GitHub:"
echo "   gh secret set ANTHROPIC_API_KEY"
echo "   (Paste your key: sk-ant-xxxxx)"
echo ""
echo "3. Enable workflow permissions:"
echo "   Settings → Actions → General → Workflow permissions"
echo "   Select 'Read and write permissions'"
echo ""
echo "4. Create labels:"
echo "   gh label create 'agent-develop' --color '0366d6'"
echo "   gh label create 'agent-qa-ready' --color '0e8a16'"
echo "   gh label create 'agent-approved' --color '2ea44f'"
echo ""
echo "5. Create your first issue:"
echo "   gh issue create \\"
echo "     --title 'Feature: Hello World API' \\"
echo "     --label 'agent-develop' \\"
echo "     --body 'Create a simple /hello endpoint that returns {\"message\": \"Hello, World!\"}'"
echo ""
echo "6. Watch the magic happen!"
echo "   Visit: https://github.com/YOUR_USERNAME/hello-world-api/actions"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
print_success "Ready to go! 🎉"
echo ""
