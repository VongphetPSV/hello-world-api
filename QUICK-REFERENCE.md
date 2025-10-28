# Quick Reference Guide
## Essential Commands and Workflows

## 🚀 Quick Start Commands

### One-Line Setup
```bash
# Clone, setup, and push
gh repo create hello-world-api --public --clone && \
cd hello-world-api && \
./setup.sh && \
gh secret set ANTHROPIC_API_KEY && \
gh label create "agent-develop" --color "0366d6"
```

### Create Feature
```bash
gh issue create \
  --title "Feature: [NAME]" \
  --label "agent-develop" \
  --body "[DESCRIPTION]"
```

### Monitor Progress
```bash
# Watch live
gh run watch

# List runs
gh run list

# View details
gh run view [RUN_ID] --log
```

### Review & Merge
```bash
# List PRs
gh pr list

# Review PR
gh pr view [PR_NUMBER]
gh pr diff [PR_NUMBER]

# Merge
gh pr merge [PR_NUMBER] --merge
```

---

## 📋 Agent Workflow Stages

### Stage 1: Architect (Agent 1)
**Trigger**: Issue labeled `agent-develop`
**Time**: 15-30 minutes
**Output**: `plans/[ISSUE_NUM]/`

```bash
# Check progress
gh run list --workflow="Agent 1 - Architect"

# View plans (after completion)
cat plans/1/architecture.md
cat plans/1/implementation.md
cat plans/1/test-plan.md
```

### Stage 2: Engineer (Agent 2)
**Trigger**: Agent 1 completion (automatic)
**Time**: 45-90 minutes
**Output**: PR with code

```bash
# Check progress
gh run list --workflow="Agent 2 - Engineer"

# View PR when ready
gh pr view --web
```

### Stage 3: QA (Agent 3)
**Trigger**: PR creation (automatic)
**Time**: 15-30 minutes
**Output**: QA report + approval/rejection

```bash
# Check progress
gh run list --workflow="Agent 3 - QA"

# View QA report
gh pr view [PR_NUMBER]  # Look in comments
```

---

## 🔧 Common Operations

### Cancel a Run
```bash
# Cancel latest run
gh run cancel $(gh run list --limit 1 --json databaseId --jq '.[0].databaseId')

# Cancel specific run
gh run cancel [RUN_ID]
```

### Rerun Failed Workflow
```bash
# Rerun latest
gh run rerun $(gh run list --limit 1 --json databaseId --jq '.[0].databaseId')

# Rerun specific
gh run rerun [RUN_ID]
```

### View Logs
```bash
# View latest logs
gh run view --log

# View specific run
gh run view [RUN_ID] --log

# Download logs
gh run download [RUN_ID]
```

### Update Secrets
```bash
# Update API key
gh secret set ANTHROPIC_API_KEY

# List secrets
gh secret list

# Delete secret
gh secret delete ANTHROPIC_API_KEY
```

---

## 🏷️ Label Management

### Create Labels
```bash
gh label create "agent-develop" --color "0366d6" --description "Trigger development"
gh label create "agent-qa-ready" --color "0e8a16" --description "Ready for QA"
gh label create "agent-approved" --color "2ea44f" --description "QA approved"
```

### Add Label to Issue
```bash
gh issue edit [ISSUE_NUMBER] --add-label "agent-develop"
```

### Remove Label
```bash
gh issue edit [ISSUE_NUMBER] --remove-label "agent-develop"
```

---

## 📊 Monitoring & Debugging

### Check Workflow Status
```bash
# All workflows
gh workflow list

# Specific workflow
gh workflow view "Agent 1 - Architect"

# Enable/disable
gh workflow enable "Agent 1 - Architect"
gh workflow disable "Agent 1 - Architect"
```

### Check Repository Settings
```bash
# View permissions
gh api repos/{owner}/{repo}/actions/permissions

# View secrets
gh secret list

# View labels
gh label list
```

### Debug Failed Run
```bash
# Get run details
gh run view [RUN_ID] --log > debug.log

# Check step that failed
cat debug.log | grep "Error\|Failed"

# View artifacts
gh run download [RUN_ID]
```

---

## 💰 Cost Tracking

### Monitor API Usage
```bash
# Visit Anthropic Console
open https://console.anthropic.com/usage

# Estimate costs
echo "Features completed: X"
echo "Estimated cost: $(($X * 10)) USD"
```

### Cost Per Feature
- Agent 1: $2-3
- Agent 2: $3-5
- Agent 3: $2-3
- **Total**: $8-10

---

## 🎯 Best Practices

### Writing Good Issues

**Good:**
```markdown
# Feature: User Authentication

Implement JWT-based authentication with:
- Login endpoint (POST /auth/login)
- Registration endpoint (POST /auth/register)
- Token validation middleware
- Password hashing (bcrypt)
- Email validation

Requirements:
- Secure password storage
- Token expiry (24h)
- Input validation
- Error handling
```

**Bad:**
```markdown
Add login feature
```

### Issue Templates

**Feature Request:**
```markdown
## Feature: [Name]

### Description
[What should this do?]

### Requirements
- [ ] Requirement 1
- [ ] Requirement 2
- [ ] Requirement 3

### Technical Details
- Stack: [technologies]
- Dependencies: [new packages]
- Integration: [existing features]

### Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2
```

**Bug Fix:**
```markdown
## Bug: [Description]

### Current Behavior
[What happens now?]

### Expected Behavior
[What should happen?]

### Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

### Environment
- Version: [version]
- OS: [operating system]
```

---

## ⚡ Power User Tips

### Parallel Development
```bash
# Create multiple features at once
for feature in "auth" "dashboard" "api"; do
  gh issue create \
    --title "Feature: $feature" \
    --label "agent-develop" \
    --body "Implement $feature module"
done
```

### Batch Operations
```bash
# Close all old issues
gh issue list --state open --json number --jq '.[].number' | \
  xargs -I {} gh issue close {}

# Merge all approved PRs
gh pr list --label "agent-approved" --json number --jq '.[].number' | \
  xargs -I {} gh pr merge {} --merge
```

### Custom Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias agent-create='gh issue create --label "agent-develop"'
alias agent-status='gh run list --limit 5'
alias agent-watch='gh run watch'
alias agent-prs='gh pr list --label "agent-approved"'
```

---

## 🔍 Troubleshooting Quick Fixes

### Workflow Not Triggering
```bash
# 1. Check label
gh label list | grep agent-develop

# 2. Check workflow files
ls -la .github/workflows/

# 3. Check Actions enabled
gh api repos/{owner}/{repo}/actions/permissions
```

### API Key Issues
```bash
# 1. Verify secret exists
gh secret list

# 2. Test key
curl https://api.anthropic.com/v1/messages \
  -H "x-api-key: YOUR_KEY" \
  -H "content-type: application/json" \
  -d '{"model":"claude-sonnet-4-20250514","max_tokens":10,"messages":[{"role":"user","content":"test"}]}'

# 3. Re-set if needed
gh secret set ANTHROPIC_API_KEY
```

### Permission Errors
```bash
# Fix in one command
gh api repos/{owner}/{repo}/actions/permissions/workflow \
  -X PUT \
  -f default_workflow_permissions=write \
  -f can_approve_pull_request_reviews=true
```

---

## 📈 Performance Optimization

### Speed Up Workflows
```yaml
# In workflow files, add caching:
- uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

### Reduce API Costs
```yaml
# Use shorter, more focused prompts
# Cache Claude responses
# Batch similar operations
```

---

## 🎓 Learning Resources

### Official Docs
- GitHub Actions: https://docs.github.com/actions
- Anthropic Claude: https://docs.anthropic.com
- Claude Code: https://docs.claude.com/claude-code

### Example Repositories
- Basic setup: [link]
- Advanced features: [link]
- Production setup: [link]

---

## 📞 Getting Help

### Before Asking
1. Check logs: `gh run view --log`
2. Search issues: `gh issue list --search "error"`
3. Read troubleshooting guide

### When Asking
Include:
- Full error message
- Run ID: `gh run list`
- Workflow file excerpt
- Steps to reproduce

### Where to Ask
- GitHub Issues: Bug reports
- GitHub Discussions: Questions
- Stack Overflow: Tag `github-actions`

---

## 🎉 Success Indicators

You're a power user when you can:
- ✅ Create features in <5 minutes
- ✅ Review PRs in <10 minutes
- ✅ Debug issues quickly
- ✅ Run multiple features in parallel
- ✅ Customize workflows for your needs

**Happy Automating!** 🚀
