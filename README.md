# env

```sh
make help             # list targets
make user             # install user configs
make etc              # install /etc configs (sudo, prompts upfront)
make etc SUDO=        # run without sudo (e.g. already root)
```

- `V=1` shows executed commands; `DRY_RUN=1` previews `lib/dot.sh` actions without applying them.
- Link groups are tracked by stamp files in `.stamps/`; re-run with `make -B <target>` or `make clean`.
- `make clean-links` removes broken links pointing into this repo.
- `make clean-backups` interactively removes `*~` backups.
