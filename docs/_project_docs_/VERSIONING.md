
# Versioning

## Release Policy

The format is based on [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### Major versions

A **major version update** is REQUIRED any time the **requirements** for any level are made more restrictive.
Examples include, but are not limited to:

- Addition of criteria using the language `MUST`, `MUST NOT`, `SHALL`, `SHALL NOT`, `REQUIRED`
- Upgrade of optional criteria to mandatory criteria
- Addition or removal of a level of requirements

### Minor versions

A **minor version update** is any update that changes criteria without making the **requirements** for any level more restrictive.
Examples of changes requiring a minor version update include, but are not limited to:

- Addition of criteria using the language `RECOMMENDED`, `MAY`, `OPTIONAL`, or `SUGGESTED`
- Removal of criteria

### Patch versions

A **patch version update** is any update that does not meet the requirements for either a major or minor version update.
Examples of changes requiring a patch version update include, but are not limited to:

- Change to the description text of a criterion to better explain the requirements or purpose
- Formatting changes to templates

### Performing a release

Follow steps from [DEV_WORKFLOW.md](DEV_WORKFLOW.md)

1. Create the release branch: `release/X.Y.Z` from `master`
2. Create the release commit, updating the version number in both [CHANGELOG.md](CHANGELOG.md) and [VERSION](../VERSION)
3. Open a pull request from `master` or `feature/ISSUE-###` to `release/X.Y.Z`
4. Changes from the Pull Request should be performed on `feature/ISSUE-###` branches, which will update the pull request
5. When the pull request is approved, merge the pull request into `release/X.Y.Z` without deleting the source branch
6. Create a release candidate tag on `release/X.Y.Z`
7. Create a CM tag from the latest verified release candidate tag

#### Example

1. Update [CHANGELOG.md](./CHANGELOG.md). Update [VERSION](../../VERSION)

   - `git log release/v1.2.3..HEAD`

2. Make updates to source branch as required

   - Rebase if desired
     - `./scripts/commit_helper.py --rebase develop feature/xx-123 --push`
