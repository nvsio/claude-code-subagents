# GitHub Actions Workflows

This directory contains GitHub Actions workflows for automated repository maintenance.

## Workflows

### 1. Self-Healing Repository (`self-healing.yml`)

The main automated maintenance workflow that:
- Runs on push, PR, schedule, or manual trigger
- Validates repository structure
- Synchronizes agent configurations
- Creates PRs for any necessary changes
- Supports GitHub App authentication for enhanced permissions

### 2. Self-Healing Repository Simple (`self-healing-simple.yml`)

A simplified version that:
- Works with just the default GITHUB_TOKEN
- Provides basic repository maintenance
- Easier to set up but with limited capabilities

### 3. Test Self-Healing (`test-self-healing.yml`)

Comprehensive test suite that validates:
- Git configuration
- PR creation capabilities
- Error handling
- Permission requirements

## Fixing Git Exit Code 128

The git exit code 128 error typically occurs due to:

1. **Missing Permissions**: Add to your workflow:
   ```yaml
   permissions:
     contents: write
     pull-requests: write
   ```

2. **Incorrect Git Configuration**: Use proper bot identity:
   ```yaml
   - name: Configure Git
     run: |
       git config user.name "github-actions[bot]"
       git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
   ```

3. **Token Issues**: Ensure proper token usage:
   ```yaml
   - uses: actions/checkout@v4
     with:
       token: ${{ secrets.GITHUB_TOKEN }}
   ```

4. **Safe Directory**: Add workspace as safe directory:
   ```yaml
   git config --add safe.directory "$GITHUB_WORKSPACE"
   ```

## Setup Instructions

### Basic Setup (Using GITHUB_TOKEN)

1. No additional configuration needed
2. Use `self-healing-simple.yml` for basic maintenance
3. Workflow will use default GITHUB_TOKEN

### Advanced Setup (Using GitHub App)

1. Create a GitHub App with these permissions:
   - Contents: Read & Write
   - Pull requests: Read & Write
   - Issues: Read & Write

2. Install the app on your repository

3. Add these secrets/variables:
   - `APP_ID`: Your GitHub App ID (as a variable)
   - `APP_PRIVATE_KEY`: Your GitHub App private key (as a secret)

4. Use `self-healing.yml` for full functionality

### With Anthropic API (For repo-updater agent)

1. Add `ANTHROPIC_API_KEY` as a repository secret
2. The workflow will use Claude to analyze and fix repository issues

## Testing

Run the test workflow to validate your setup:

```bash
gh workflow run test-self-healing.yml -f test_scenario=all
```

## Troubleshooting

### PR Creation Fails

1. Check repository settings:
   - Allow GitHub Actions to create PRs
   - Disable branch protection for auto/* branches

2. Verify permissions in workflow file

3. Run test workflow to diagnose issues

### Git Operations Fail

1. Ensure git is properly configured
2. Check token permissions
3. Verify branch protection rules

### Workflow Doesn't Trigger

1. Check workflow syntax
2. Verify branch names in triggers
3. Ensure workflow file is in default branch

## Best Practices

1. **Use Skip CI**: Add `[skip ci]` to automated commits to prevent loops
2. **Clean Up**: Always clean up temporary files
3. **Error Handling**: Use `continue-on-error` for non-critical steps
4. **Logging**: Add descriptive echo statements for debugging
5. **Idempotency**: Ensure workflows can run multiple times safely