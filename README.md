# claude-code-subagents

self-improving ai agents that actually work™

## what

a collection of claude code agents that get better at their jobs. they learn. they adapt. they ship.

## why

because your ai assistant should level up faster than you do

## how claude works here

### 1. agents as markdown
each agent is defined in `.claude/agents/` as a markdown file that tells claude:
- what it specializes in
- which tools it can use
- when to activate
- how to self-improve

### 2. self-healing automation
this repo uses github actions + claude api to:
- check agent configurations daily
- fix sync issues automatically
- suggest improvements based on usage
- maintain itself without human intervention

### 3. using agents in claude code
```bash
# in claude code, just mention the agent
@agent-repo-updater   # maintains agent configs
@agent-chief-product-officer   # reviews ui/ux
```

## setup

```bash
# clone it
git clone https://github.com/nvsio/claude-code-subagents

# add to your claude code project
cp -r .claude /your/project/

# agents are now available via @ mentions
```

## current roster

- **repo-updater**: self-improving maintenance agent. keeps all agents in sync, suggests optimizations
- **chief-product-officer**: ui/ux review specialist. catches accessibility issues, ensures consistency

## self-healing workflow

the repo maintains itself using claude:
1. github action runs on schedule/push
2. calls claude api to check repo health
3. auto-commits fixes if needed
4. no PRs needed (avoids permission issues)

to enable in your repo:
```yaml
# add ANTHROPIC_API_KEY to github secrets
# copy .github/workflows/self-healing.yml
```

## philosophy

- agents should be excellent at one thing
- self-improvement isn't a feature, it's table stakes
- if it's not making you faster, it's not worth it

## contribute

drop a PR. doesn't have to be perfect—between the repo-updater agent and human review, we'll get it polished.

ideas for agents we'd love:
- **test-runner**: intelligently runs only affected tests
- **doc-writer**: generates docs from code changes  
- **perf-optimizer**: finds and fixes performance bottlenecks
- **security-scanner**: proactive vulnerability detection

rough edges are fine. iteration is the name of the game.

---

*built for developers who ship*
