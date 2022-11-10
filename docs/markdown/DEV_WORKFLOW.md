
# Branching Model

## Model

Simple model

<!-- TODO: insert model? -->
```text
release/1.1.0                                                                 o <=RC_TAG/CM_TAG
                                                                             /
release/1.0.0                    RC_TAG=> o-----------------------------o <=RC_TAG/CM_TAG
                                         / \                           / \ /
master                -o---o---------o--o---\--o------------------o---/---o
                        \   \       /  /     \  \                /   /
feature/my-update       -o---\--o--o  /       \  \              /   /
                              \      /         \  \            /   /
feature/another-update        -o--o-o           \  \          /   /
                                                 \  \        /   /
bugfix/thing-to-fix                              -o--\-o----/---o
                                                      \    /
bugfix/another-fix                                    -o--o
```
