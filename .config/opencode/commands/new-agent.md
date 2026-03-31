---
name: new-agent
description: creates a new Agent-template
agent: build
---

# Steps to follow:

1. if `$ARGUMENTS` is empty => ask the user for the Name of the Agent to create.
   - refere to the given Agent as `$AGENTNAME`

2. ask the user on where to create the agent (refere to this as `$TARGETDIR`)
   - multiple choice options:
     - "current project"
     - "all projects"

3. create an "`$AGENTNAME`.md" file in a location based on the given `$TARGETDIR`

| `$TARGETDIR`    | Location                                      |
| --------------- | --------------------------------------------- |
| current Project | ./.opencode/agents/`$AGENTNAME`.md            |
| all projects    | $HOME/.config/opencode/agents/`$AGENTNAME`.md |

You then output the file to the current cwds `.opencode/agents/agentname.md` folder.
Do not do anything else. Write the file exactly as stated inside the \`\`\`markdown ... \`\`\` block.

# Markdown-Template

```markdown
---
description: what does our agent do
mode: subagent | primary
model: ollama.local/qwen3:1.7b-q8_0
temperature: 0.1
tools:
  bash: true
  edit: true
  glob: true
  grep: true
  read: true
  write: true
  question: true
  task: true
  webfetch: true
  websearch: true
  codesearch: true

permissions:
  bash: "ask"
  edit: "ask"
  glob: "ask"
  grep: "ask"
  read: "ask"
  write: "ask"
  question: "ask"
  task: "ask"
  webfetch: "ask"
  websearch: "ask"
  codesearch: "ask"
  skill: "ask"
  file_allow: "ask"
  file_deny: "ask"
  network_allow: "ask"
  network_deny: "ask"
  shell_allow: "ask"
  shell_deny: "ask"
  skill: allow
---
```
