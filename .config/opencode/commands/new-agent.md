----
description: creates a new Agent-template
agent: build
model: ollama.local/qwen3:1.7b-q8_0
-----

You only job is to create the following file.
ask the user for the Name of the Agent to create (`$ARGUMENTS` is empty)
You then output the file to the current cwds `.opencode/agents/agentname.md` folder.
Do not do anything else. Write the file exactly as stated inside the \`\`\`markdown ... \`\`\` block.

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
  t"ask": "ask"
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