# Project Template

> This is a project

## Start Here

**--> [Quick Start][quick start] <--**

## Project Links

Name                      | Link
--                        | --
website                   | [Confluence][website]
documentation             | [Documentation][documentation]
bug tracker               | [Jira][bugtracker]
repository                | [BitBucket][repo]
continuous integration    | [Jenkins][ci]

## Project Reference

Name                      | Link
--                        | --
version                   | [Version][version]
quick start instructions  | [Instructions][quick start]
license                   | [License][license]
contributing instructions | [Contributing][contributing]
Style Guide               | [Style][code_style]
Open Source Software      | [OSS][oss]
Branching Model           | [Branch Model][branch_model]
Versioning                | [Versioning][versioning]
Change Log                | [Change Log][changelog]

## Project Status

Name                      | Status
--                        | --
Build Status              | [![Build Status][ci-build-badge]][ci-build]

## Abstract

> This file should be modified by the program that is copying it to contain
information about the project. The Project Template provides automatic hooks
for multi-tiered distributed build and test processes. The Project Template
also includes hooks for DevSecOps integration.

This project uses a `make.py` wrapper script to provide basic helper operations.

## Installation

```console
# git clone --recurse-submodules <repo>/<project>/<repository>.git
# <repository>/make.py install
```

## Quick Start

See [quick start] for more details.

### Basic commands

```console
# ./make.py --help
# ./make.py --build
# ./make.py --test
# ./make.py --scan
# ./make.py --docs
# ./make.py --verify
```

[website]: http://esconfluence/
[ci]: .
[documentation]: docs/
[bugtracker]: http://esjira.goldlnk.rootlnka.net/
[repo]: http://esbitbucket.goldlnk.rootlnka.net/projects/

[ci-build-badge]: http://badgen.net/badge/build/unknown/grey

[quick start]: docs/md/QUICK_START.md
[versioning]: docs/md/VERSIONING.md
[code_style]: docs/md/CODE_STYLE.md
[branch_model]: docs/md/DEV_WORKFLOW.md
[changelog]: docs/md/CHANGELOG.md

[contributing]: docs/md/CONTRIBUTING.md
[license]: docs/md/LICENSE
[version]: docs/md/VERSION
