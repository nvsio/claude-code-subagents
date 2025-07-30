# GitHub Action Setup for Self-Healing Repository

## Overview

These GitHub Actions provide automated maintenance for your claude-code-subagents repository using the repo-updater agent. The system is designed to be cost-efficient while keeping your repository healthy.

## Cost Optimization Features

1. **Tiered Maintenance Modes**:
   - **Light**: Quick validation only (~$0.01 per run)
   - **Standard**: Sync and fixes (~$0.05 per run)
   - **Deep**: Full analysis (~$0.10 per run)

2. **Smart Scheduling**:
   - Runs twice weekly by default (not daily)
   - Automatically selects appropriate mode based on last run
   - Manual override available for urgent maintenance

3. **Efficient API Usage**:
   - Short timeouts to prevent runaway costs
   - Limited tool access based on maintenance mode
   - Early exit if no issues found

## Setup Instructions

### 1. Add API Key to GitHub Secrets

Go to your repository settings → Secrets and variables → Actions

Add a new secret:
- Name: `ANTHROPIC_API_KEY`
- Value: Your Claude API key

### 2. Choose Your Workflow

**Option A: Basic Schedule (repo-updater-schedule.yml)**
- Simple daily validation
- Creates PRs for any issues
- Good for active repositories

**Option B: Advanced Smart Maintenance (repo-updater-advanced.yml)**
- Cost-optimized with tiered modes
- PR review capabilities
- Recommended for most use cases

### 3. Deploy the Workflow

```bash
# Create the workflows directory in your private repo
mkdir -p .github/workflows

# Copy your chosen workflow
cp .github-action-private/repo-updater-advanced.yml .github/workflows/

# Commit and push
git add .github/workflows/repo-updater-advanced.yml
git commit -m "feat: add self-healing maintenance workflow"
git push
```

### 4. Configure Auto-merge (Optional)

If you trust the automated fixes, uncomment the auto-merge section in the workflow.

## Usage

### Manual Trigger

Go to Actions tab → Select workflow → Run workflow → Choose maintenance mode

### Monitor Costs

Estimated monthly costs:
- Light mode only: ~$0.10/month
- Mixed mode (automatic): ~$0.50/month  
- Deep mode weekly: ~$1.00/month

### PR Review

The system will:
1. Create detailed PRs with changes
2. Label them appropriately
3. Include cost estimates
4. Show what was changed and why

## Best Practices

1. **Start with Light Mode**: Monitor how often changes are needed
2. **Review First Few PRs**: Ensure the agent makes sensible changes
3. **Adjust Schedule**: If no changes for weeks, reduce frequency
4. **Use Manual Trigger**: For immediate maintenance when adding new agents

## Troubleshooting

### High Costs
- Check workflow run history for long execution times
- Reduce schedule frequency
- Use light mode more often

### No PRs Created
- Agent found no issues (good!)
- Check workflow logs for validation results
- Manually trigger deep mode for thorough check

### Failed Workflows
- Verify API key is set correctly
- Check Claude API status
- Review error logs in Actions tab

## Security Notes

- Never commit these workflows to public repos with secrets
- Use GitHub's built-in secret scanning
- Rotate API keys periodically
- Monitor usage in Claude dashboard