#

## Install ansible lint with pipx

```bash
pipx install -f --include-deps ansible
pipx inject --include-apps ansible 'ansible-lint[community,yamllint]' jmespath netaddr
```
