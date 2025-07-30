#!/bin/bash
# Diagnostic script for GitHub Actions git issues

echo "=== Git Diagnostics ==="
echo ""

echo "1. Environment Information:"
echo "   - Runner: ${RUNNER_NAME:-local}"
echo "   - OS: ${RUNNER_OS:-$(uname -s)}"
echo "   - Workspace: ${GITHUB_WORKSPACE:-$(pwd)}"
echo "   - Repository: ${GITHUB_REPOSITORY:-unknown}"
echo ""

echo "2. Git Configuration:"
git config --list | grep -E "(user\.|safe\.|core\.)" | sort
echo ""

echo "3. Repository Status:"
git status --porcelain
echo ""

echo "4. Remote Configuration:"
git remote -v
echo ""

echo "5. Branch Information:"
echo "   - Current branch: $(git branch --show-current)"
echo "   - All branches:"
git branch -a
echo ""

echo "6. Token/Permission Check:"
if [ -n "$GITHUB_TOKEN" ]; then
    echo "   - GITHUB_TOKEN is set"
    # Test API access
    if command -v gh &> /dev/null; then
        echo "   - Testing GitHub CLI access..."
        gh auth status 2>&1 | grep -E "(Logged in|Token:|Protocol:)" || echo "     Failed to get auth status"
    fi
else
    echo "   - GITHUB_TOKEN is NOT set"
fi
echo ""

echo "7. Common Issues Check:"

# Check if in git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "   ❌ Not in a git repository!"
fi

# Check if remote is accessible
if ! git ls-remote > /dev/null 2>&1; then
    echo "   ❌ Cannot access remote repository!"
fi

# Check for uncommitted changes
if [[ -n $(git status --porcelain) ]]; then
    echo "   ⚠️  Uncommitted changes detected"
fi

# Check git version
echo "   - Git version: $(git --version)"

echo ""
echo "=== End Diagnostics ==="