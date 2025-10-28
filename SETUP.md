# Setup Guide: Hello World API
## Complete Installation and Configuration

## Overview

This guide will walk you through setting up a fully autonomous 3-agent development system in **under 30 minutes**. By the end, you'll have:

- ✅ 3 AI agents working autonomously
- ✅ Automated planning, implementation, and QA
- ✅ Your first "Hello World" API deployed
- ✅ A system ready for real features

**Total Time**: 25-30 minutes
**Cost**: ~$8-10 per feature (Anthropic API)

---

## Prerequisites

### Required

1. **GitHub Account** (free or pro)
   - Sign up at: https://github.com/signup
   - Enable GitHub Actions (included with all plans)

2. **Anthropic API Key** ($5 credit to start)
   - Get at: https://console.anthropic.com
   - Cost: ~$0.015 per 1K tokens
   - Expected: $8-10 per feature

3. **Node.js 18+**
   - Download: https://nodejs.org
   - Verify: `node -v` (should show v18.x.x or higher)

4. **Git** (for version control)
   - Download: https://git-scm.com
   - Verify: `git --version`

### Recommended

5. **GitHub CLI** (optional, makes setup easier)
   - Install: https://cli.github.com
   - Verify: `gh --version`

6. **VS Code** or your favorite editor

---

## Part 1: Local Setup (10 minutes)

### Step 1: Download Files (2 minutes)

Download the three workflow files and setup script:

1. `agent-1-architect.yml`
2. `agent-2-engineer.yml`
3. `agent-3-qa.yml`
4. `setup.sh`

Place them in a new directory:

```bash
mkdir hello-world-api
cd hello-world-api

# Copy downloaded files here
# OR download directly:
curl -O [URL_TO_FILES]/agent-1-architect.yml
curl -O [URL_TO_FILES]/agent-2-engineer.yml
curl -O [URL_TO_FILES]/agent-3-qa.yml
curl -O [URL_TO_FILES]/setup.sh

# Make setup script executable
chmod +x setup.sh
```

### Step 2: Run Automated Setup (3 minutes)

```bash
# Run the setup script
./setup.sh
```

This script will:
- ✅ Check prerequisites
- ✅ Create directory structure
- ✅ Install workflow files
- ✅ Create package.json
- ✅ Initialize Git repository
- ✅ Create initial commit

**Expected output:**
```
🚀 3-Agent Autonomous Development System - Setup
================================================

📋 Checking prerequisites...
✓ Node.js installed: v20.x.x
✓ Git installed: git version 2.x.x
✓ GitHub CLI installed: gh version 2.x.x

📁 Creating project structure...
✓ Directories created

🤖 Installing agent workflows...
✓ Agent 1 (Architect) workflow installed
✓ Agent 2 (Engineer) workflow installed
✓ Agent 3 (QA) workflow installed

✅ Setup complete!
```

### Step 3: Verify Structure (1 minute)

Your directory should now look like:

```
hello-world-api/
├── .github/
│   └── workflows/
│       ├── agent-1-architect.yml
│       ├── agent-2-engineer.yml
│       └── agent-3-qa.yml
├── plans/                  (empty, agents will fill)
├── qa-reports/            (empty, agents will fill)
├── src/                   (empty, agents will create)
├── tests/                 (empty, agents will create)
├── .gitignore
├── package.json
└── README.md
```

---

## Part 2: GitHub Setup (10 minutes)

### Step 4: Create GitHub Repository (2 minutes)

**Option A: Using GitHub CLI (recommended)**
```bash
# Create and push to GitHub
gh repo create hello-world-api --public --source=. --push

# Verify
gh repo view --web
```

**Option B: Using GitHub Web UI**
1. Go to https://github.com/new
2. Name: `hello-world-api`
3. Description: "3-agent autonomous development demo"
4. Public repository
5. Do NOT initialize with README (we have one)
6. Click "Create repository"

Then push your local code:
```bash
git remote add origin https://github.com/YOUR_USERNAME/hello-world-api.git
git branch -M main
git push -u origin main
```

### Step 5: Configure Secrets (2 minutes)

**You need to add your Anthropic API key as a secret.**

**Option A: Using GitHub CLI**
```bash
# Set the API key
gh secret set ANTHROPIC_API_KEY

# When prompted, paste your key:
# sk-ant-api03-xxxxxxxxxxxxxxxxxxxxx

# Verify it's set
gh secret list
# Should show: ANTHROPIC_API_KEY
```

**Option B: Using GitHub Web UI**
1. Go to your repo → **Settings**
2. Left sidebar → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `ANTHROPIC_API_KEY`
5. Value: Your API key (starts with `sk-ant-`)
6. Click **Add secret**

### Step 6: Configure Permissions (3 minutes)

**GitHub Actions needs write permissions to create branches and PRs.**

**Using GitHub Web UI:**
1. Go to: **Settings** → **Actions** → **General**
2. Scroll to **Workflow permissions**
3. Select: **Read and write permissions**
4. Check: ☑ **Allow GitHub Actions to create and approve pull requests**
5. Click: **Save**

**Using GitHub CLI:**
```bash
gh api repos/{owner}/hello-world-api/actions/permissions \
  -X PUT \
  -f enabled=true \
  -f allowed_actions=all

gh api repos/{owner}/hello-world-api/actions/permissions/workflow \
  -X PUT \
  -f default_workflow_permissions=write \
  -f can_approve_pull_request_reviews=true
```

### Step 7: Create Labels (2 minutes)

**Using GitHub CLI:**
```bash
gh label create "agent-develop" \
  --description "Trigger 3-agent development" \
  --color "0366d6"

gh label create "agent-qa-ready" \
  --description "Ready for QA validation" \
  --color "0e8a16"

gh label create "agent-approved" \
  --description "QA approved - ready to merge" \
  --color "2ea44f"

# Verify
gh label list
```

**Using GitHub Web UI:**
1. Go to: **Issues** → **Labels**
2. Click: **New label**
3. Create these three labels:
   - Name: `agent-develop`, Color: `#0366d6`
   - Name: `agent-qa-ready`, Color: `#0e8a16`
   - Name: `agent-approved`, Color: `#2ea44f`

---

## Part 3: First Test Run (10 minutes)

### Step 8: Create Your First Issue (2 minutes)

**Using GitHub CLI:**
```bash
gh issue create \
  --title "Feature: Hello World API" \
  --label "agent-develop" \
  --body "Create a simple REST API with a /hello endpoint that returns: {\"message\": \"Hello, World!\", \"timestamp\": \"<current-time>\"}"
```

**Using GitHub Web UI:**
1. Go to: **Issues** → **New issue**
2. Title: `Feature: Hello World API`
3. Body:
   ```
   Create a simple REST API with a /hello endpoint that returns:
   {
     "message": "Hello, World!",
     "timestamp": "<current-time>"
   }
   
   Requirements:
   - Use Express.js
   - Return JSON
   - Include timestamp
   - Add tests
   ```
4. Label: Add `agent-develop`
5. Click: **Submit new issue**

### Step 9: Watch the Agents Work (5 minutes)

**The 3-agent system now springs into action automatically!**

1. **Go to Actions tab**: https://github.com/YOUR_USERNAME/hello-world-api/actions

2. **Watch Agent 1 (Architect)** - ~15 minutes
   - Planning the architecture
   - Creating implementation guide
   - Defining test strategy
   - **Output**: `plans/1/` directory with 3 markdown files

3. **Watch Agent 2 (Engineer)** - ~45 minutes
   - Implementing the code
   - Writing tests
   - Creating documentation
   - **Output**: Pull request with working code

4. **Watch Agent 3 (QA)** - ~20 minutes
   - Running all tests
   - Security scanning
   - Coverage analysis
   - **Output**: QA report with APPROVE/REJECT

**Real-time monitoring:**
```bash
# Watch workflow status
gh run watch

# Or check status
gh run list
```

### Step 10: Review and Merge (3 minutes)

After ~1.5-2 hours, you'll have a pull request ready!

**Review the PR:**
```bash
# List PRs
gh pr list

# View details
gh pr view [PR_NUMBER]

# Check the QA report in PR comments
```

**If approved by Agent 3:**
```bash
# Review the code one final time
gh pr diff [PR_NUMBER]

# Merge it!
gh pr merge [PR_NUMBER] --merge

# Or use GitHub UI to merge
```

**Test your API:**
```bash
# Install dependencies
npm install

# Start the server
npm start

# Test the endpoint
curl http://localhost:3000/hello

# Expected output:
# {"message":"Hello, World!","timestamp":"2024-..."}
```

---

## Verification Checklist

After setup, verify everything works:

### ✅ Repository Setup
- [ ] Repository created on GitHub
- [ ] Code pushed to `main` branch
- [ ] Workflows visible in `.github/workflows/`

### ✅ Secrets & Permissions
- [ ] `ANTHROPIC_API_KEY` secret set
- [ ] Workflow permissions: Read and write
- [ ] PR creation enabled

### ✅ Labels
- [ ] `agent-develop` label exists
- [ ] `agent-qa-ready` label exists
- [ ] `agent-approved` label exists

### ✅ First Run
- [ ] Issue created with `agent-develop` label
- [ ] Agent 1 workflow triggered
- [ ] Plans created in `plans/1/`
- [ ] Agent 2 created PR
- [ ] Agent 3 posted QA report
- [ ] PR ready to merge

---

## Troubleshooting

### Issue: Workflow doesn't trigger

**Check:**
1. Label is exactly `agent-develop` (case-sensitive)
2. Workflow files in `.github/workflows/`
3. Actions enabled: Settings → Actions → General

**Fix:**
```bash
# Verify label
gh label list | grep agent-develop

# Check workflows
ls -la .github/workflows/

# Manually trigger (test)
gh workflow run "Agent 1 - Architect"
```

### Issue: API key error

**Error:** "ANTHROPIC_API_KEY not found"

**Fix:**
```bash
# Check secret exists
gh secret list

# Re-set if needed
gh secret set ANTHROPIC_API_KEY

# Test key validity
curl https://api.anthropic.com/v1/messages \
  -H "x-api-key: YOUR_KEY" \
  -H "content-type: application/json" \
  -d '{"model":"claude-sonnet-4-20250514","max_tokens":10,"messages":[{"role":"user","content":"test"}]}'
```

### Issue: Permission denied (git push)

**Error:** "Permission denied" in workflow

**Fix:**
1. Settings → Actions → General
2. Workflow permissions → "Read and write"
3. Check "Allow GitHub Actions to create PRs"
4. Save

### Issue: Agent takes too long

**Expected times:**
- Agent 1: 15-30 minutes
- Agent 2: 45-90 minutes
- Agent 3: 15-30 minutes

**If stuck >2 hours:**
```bash
# Cancel run
gh run cancel [RUN_ID]

# Check logs
gh run view [RUN_ID] --log

# Try simpler requirement
```

---

## Cost Management

### Expected Costs

**Per feature:**
- Agent 1 (Planning): $2-3
- Agent 2 (Implementation): $3-5
- Agent 3 (QA): $2-3
- **Total: ~$8-10 per feature**

**Monthly estimates:**
- 10 features: $80-100
- 25 features: $200-250
- 50 features: $400-500

### Monitor Usage

1. **Anthropic Console**: https://console.anthropic.com/usage
2. **Set billing alerts** at $50, $100, $200
3. **Review weekly** to catch runaway costs

### Optimize Costs

```bash
# Use shorter prompts (in workflow files)
# Cache dependencies
# Run fewer test iterations
```

---

## Next Steps

### 1. Create Real Features

Now that you've validated the system works, create real issues:

```bash
gh issue create \
  --title "Feature: User Authentication" \
  --label "agent-develop" \
  --body "$(cat requirements/user-auth.md)"
```

### 2. Customize for Your Stack

Edit workflow files to match your tech stack:
- Change from Express to FastAPI
- Add database migrations
- Configure deployment

### 3. Add More Agents

Create specialized agents:
- Agent 4: Deployment
- Agent 5: Documentation
- Agent 6: Performance optimization

### 4. Scale Usage

Run multiple features in parallel:
```bash
# Create 5 issues at once
for i in {1..5}; do
  gh issue create --label "agent-develop" --title "Feature $i"
done
```

---

## Support

### Getting Help

1. **Documentation**: Check project README and docs/
2. **Issues**: Search existing GitHub Issues
3. **Discussions**: GitHub Discussions for questions
4. **Logs**: Check Actions logs for errors

### Reporting Issues

When reporting problems, include:
- Full error message
- Workflow file (relevant section)
- Steps to reproduce
- Expected vs actual behavior

---

## Success Criteria

You're ready for production when:

- ✅ Setup completed in <30 minutes
- ✅ First feature deployed successfully
- ✅ All 3 agents working autonomously
- ✅ QA gates passing consistently
- ✅ Understanding agent workflow
- ✅ Confident to create real issues

**Congratulations!** You now have an autonomous development system. 🎉

---

**Next**: Create your first real feature and experience 10x development speed!
