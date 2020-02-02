## Usage

```yml
resources:
- name: repo
  type: git
  source:
  source:
    uri: git@github.com:****/****.git
    private_key: ((github-private-key))
    branch: master
- name: tasks
  type: git
  source:
    uri: https://github.com/making/concourse-tasks.git

jobs:
- name: update-date
  plan:
  - get: repo
  - get: tasks
  - task: update-date
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: ubuntu
          tag: bionic
      outputs:
      - name: out
      run:
        path: bash
        args: 
        - -c
        - |
          date > out/date.txt 
  - task: make-commit
    file: tasks/make-git-commit/task.yml
    input_mapping:
      repository: repo
      file-source: out
    params:
      FILE_SOURCE_PATH: date.txt
      FILE_DESTINATION_PATH: log/date.txt
      GIT_AUTHOR_EMAIL: "bot@example.com"
      GIT_AUTHOR_NAME: "Bot"
      COMMIT_MESSAGE: "Update date.txt"
  - put: repo
    params:
      repository: repository-commit
      merge: true     
```