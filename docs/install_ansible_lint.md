# Run ansible-lint with uvx

Run the CLI in an isolated, cached environment without installing it globally:

```bash
uvx ansible-lint
```

For a project that needs Ansible collections or extra Python dependencies, declare them in that project's `pyproject.toml` instead of injecting them into a shared tool environment.
