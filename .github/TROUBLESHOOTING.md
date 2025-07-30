# Troubleshooting GitHub Actions Git Exit Code 128

## Quick Fix Checklist

### 1. Permissions
```yaml
permissions:
  contents: write
  pull-requests: write
  issues: write  # Optional, for commenting
```

### 2. Git Configuration
```yaml
- name: Configure Git
  run: |
    git config --local user.name "github-actions[bot]"
    git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git config --global --add safe.directory "$GITHUB_WORKSPACE"
```

### 3. Checkout Configuration
```yaml
- uses: actions/checkout@v4
  with:
    token: ${{ secrets.GITHUB_TOKEN }}
    fetch-depth: 0  # For full history
```

### 4. Peter Evans Create PR Action
```yaml
- uses: peter-evans/create-pull-request@v6
  with:
    token: ${{ secrets.GITHUB_TOKEN }}
    commit-message: "Your message here"
    branch: unique-branch-name-${{ github.run_number }}
    delete-branch: true
```

## Common Error Messages and Solutions

### "fatal: not a git repository"
- Ensure checkout action runs before git commands
- Verify working directory is correct

### "fatal: could not read Username"
- Git user.name not configured
- Add git config commands before any git operations

### "permission denied"
- Missing workflow permissions
- Token doesn't have required scopes
- Branch protection rules blocking automation

### "failed to push some refs"
- Branch already exists (use unique branch names)
- Force push protection enabled
- Outdated local repository

## Debugging Steps

1. **Run Diagnostic Script**:
   ```yaml
   - name: Diagnose Git Issues
     run: bash .github/scripts/diagnose-git.sh
   ```

2. **Enable Debug Logging**:
   - Set secret: `ACTIONS_STEP_DEBUG` = `true`
   - Set secret: `ACTIONS_RUNNER_DEBUG` = `true`

3. **Test Minimal Workflow**:
   - Use `self-healing-simple.yml` first
   - Gradually add complexity

4. **Verify Repository Settings**:
   - Settings → Actions → General
   - Allow GitHub Actions to create and approve PRs
   - Workflow permissions: Read and write

## Emergency Fixes

If nothing else works:

1. **Use PAT Instead**:
   ```yaml
   - uses: actions/checkout@v4
     with:
       token: ${{ secrets.PAT_TOKEN }}
   ```

2. **Manual Git Push**:
   ```yaml
   - name: Manual PR Creation
     run: |
       git checkout -b fix-branch
       git add .
       git commit -m "fixes"
       git push origin fix-branch
       gh pr create --fill
   ```

3. **Use Different Action**:
   - Try `actions/github-script`
   - Use GitHub API directly

## Prevention

1. Always test workflows in a test repository first
2. Use branch protection bypass for automation
3. Monitor workflow runs for early warning signs
4. Keep workflows simple and modular