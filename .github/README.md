## Automatic builds

An automatic build will be triggered upon the push of a tag.
A module `.zip` file for Zabbix 6.2 and older will be generated when the `manifest.5.0.json` file is present in the root of the repository.
A module `.zip` file for Zabbix 6.4 and newer will be generated when the `manifest.6.4.json` file is present in the root of the repository.

## Versioning

The module version uses only the MINOR and PATCH parts of semantic versioning.
The build tag should contain only `minor.patch` parts; it is allowed to be prefixed with the `v` character.

## Release notes generation

Release notes are generated only when the `RELEASE_NOTES.md` file is present in the root of the repository. An example can be found in the `.github/templates` directory.
Commits with message prefixes `feat:` and `fix:` will be included in the automatically generated release notes changes list.
