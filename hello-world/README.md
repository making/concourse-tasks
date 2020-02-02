## Usage

```yml
resources:
- name: tasks
  type: git
  source:
    uri: https://github.com/making/concourse-tasks
  
jobs:
- name: hello-world
  plan:
  - get: tasks
  - task: say-hello
    file: tasks/hello-world/task.yml
```