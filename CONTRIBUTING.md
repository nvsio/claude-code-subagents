# Contributing to claude-code-subagents

Thanks for considering a contribution! This repo is designed to be welcoming to all skill levels.

## Quick Start

1. Fork the repo
2. Add your agent to `.claude/agents/your-agent-name.md`
3. Submit a PR
4. Claude will review it automatically

That's it. No complex process.

## Agent Template

```markdown
# your-agent-name

## Description
What your agent does in one sentence.

## Type
your-agent-type

## Tools
- List
- Of
- Tools

## Purpose
Detailed explanation of what problems this agent solves.

## When to Use
- Specific scenario 1
- Specific scenario 2

## Example Usage
\`\`\`
@agent-your-agent-name do something cool
\`\`\`
```

## What Makes a Good Agent

- **Focused**: Does one thing exceptionally well
- **Self-Improving**: Can analyze its own performance
- **Well-Documented**: Clear examples and use cases
- **Tool-Appropriate**: Uses only the tools it needs

## PR Review Process

1. **Automatic Review**: Claude reviews within 30 seconds
2. **Feedback**: You'll get specific, actionable feedback
3. **Iteration**: Update based on suggestions
4. **Merge**: Once approved, we merge quickly

## Need Help?

- Check existing agents for examples
- Open an issue with questions
- The repo-updater agent will help validate your configs

Remember: rough edges are fine. We iterate in public.