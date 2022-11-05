Project Template
===============================================================================

> This is a project

Start Here
-------------------------------------------------------------------------------
**--> [Quick Start][quick start] <--**

Project Links
-------------------------------------------------------------------------------
Name                      | Link
--                        | --
website                   | [Confluence][website]
documentation             | [Documentation][documentation]
bug tracker               | [Jira][bugtracker]
repository                | [BitBucket][repo]
continuous integration    | [Jenkins][ci]

Project Reference
-------------------------------------------------------------------------------
Name                      | Link
--                        | --
version                   | [Version][version]
quick start instructions  | [Instructions][quick start]
license                   | [License][license]
restrictions              | [Restrictions][restrictions]
contributing instructions | [Contributing][contributing]
Style Guide               | [Style][code_style]
reuse checklist           | [Reuse][reuse]
Open Source Software      | [OSS][oss]
Branching Model           | [Branch Model][branch_model]
Versioning                | [Versioning][versioning]
Change Log                | [Change Log][changelog]

Project Status
-------------------------------------------------------------------------------
Name                      | Status
--                        | --
Reuse                     | ![reuse][reuse-badge]
Build Status              | [![Build Status][ci-build-badge]][ci-build]
Docs Status               | [![Docs Status][ci-docs-badge]][ci-docs]
Scan Status               | [![Scan Status][ci-scan-badge]][ci-scan]
Test Status               | [![Test Status][ci-test-badge]][ci-test]
Verify Status             | [![Verify Status][ci-verify-badge]][ci-verify]
Code Coverage Status      | ![codecov-badge]

Abstract
-------------------------------------------------------------------------------

> This file should be modified by the program that is copying it to contain
information about the project. The Project Template provides automatic hooks
for multi-tiered distributed build and test procesess. The Project Template
also includes hooks for DevSecOps integration.

This project uses a `make.py` wrapper script to provide basic helper operations.

### Tool Support

Type               | Name            | Supported | Comment
------------------ | --------------- | --------- | ----------------------------
Pipeline           | Jenkins         | X         | Integrated CI/CT, Deployment
SCM                | Git             | X         | Integrated, Automated
Build              | Cmake           | X         | Integrated, Automated
Build              | Maven           | X         | Integrated, Automated
Build              | Gradle          | X         | Integrated, Automated
Build              | Ant             | X         | Integrated, Automated
Unit Testing       | catch           | X         | Integrated, Automated
Unit Testing       | pytest          | X         | Integrated, Automated
Unit Testing       | googletest      |           | N/A
Unit Testing       | Junit           |           | N/A
System Testing     | COSMOS          |           | N/A
Security Testing   | Fortify         |           | N/A
Security Testing   | Coverify        |           | N/A
Scanning           | cppcheck        | X         | Integrated, Automated
Scanning           | UCC             | X         | Integrated, Automated
Scanning           | cloc            | X         | Integrated, Automated
Scanning           | pylint          | X         | Integrated, Automated
Scanning           | valgrind        | X         | Integrated, Automated
Scanning           | gcovr           | X         | Integrated, Automated
Scanning           | coverage_py     | X         | Integrated, Automated
Scanning           | Checkstyle      | X         | Integrated, Automated
Artifacts          | Jenkins         | X         | Integrated, Automated
Artifacts          | yum             |           | N/A
Artifacts          | Artifactory     |           | N/A
Artifacts          | Maven           |           | N/A
Deploy and Operate | Ansible         |           | N/A
Deploy and Operate | Puppet          |           | N/A
Deploy and Operate | Chef            |           | N/A
Monitor            | Splunk          |           | N/A
Monitor            | Nagios          |           | N/A
Containers         | Docker          | X         | Integrated, Automated
Documentation      | doxygen         | X         | Integrated, Automated
Documentation      | sphinx          | X         | Integrated, Automated
Engineering        | Jira            | X         | Integrated, Automated
Engineering        | Bitbucket       | X         | Supported
Engineering        | MagicDraw       |           | N/A
Engineering        | DOORS           |           | N/A

Installation
-------------------------------------------------------------------------------

```console
> git clone --recurse-submodules ssh://git@esbitbucket.goldlnk.rootlnka.net:7999/<project>/<repository>.git --branch master my_project
> my_project/make.py install
```

Quick Start
-------------------------------------------------------------------------------

See [quick start] for more details.

#### Basic commands
```console
> ./make.py --help
> ./make.py --build
> ./make.py --test
> ./make.py --scan
> ./make.py --docs
> ./make.py --verify
```

[website]: http://esconfluence/
[ci]: .
[documentation]: docs/
[bugtracker]: http://esjira.goldlnk.rootlnka.net/
[repo]: http://esbitbucket.goldlnk.rootlnka.net/projects/

[reuse-badge]: http://badgen.net/badge/reuse/ready/blue
[ci-build-badge]: http://badgen.net/badge/build/unknown/grey
[codecov-badge]: http://badgen.net/badge/codecov/unknown/grey

[quick start]: docs/md/QUICK_START.md
[versioning]: docs/md/VERSIONING.md
[code_style]: docs/md/CODE_STYLE.md
[branch_model]: docs/md/DEV_WORKFLOW.md
[changelog]: docs/md/CHANGELOG.md

[contributing]: docs/md/CONTRIBUTING.md
[license]: docs/md/LICENSE
[version]: docs/md/VERSION
