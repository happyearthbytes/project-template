#!/bin/env python
import subprocess
import sys
from subprocess import call


def top_level():
    """
    This returns the root of the git repository
    """
    command = "git rev-parse --show-toplevel"
    rval = subprocess.check_output(command.split(" ")).strip()
    return rval


def link_hooks():
    """
    This links your git hooks
    """
    proj_root = top_level()
    rval = 0
    # First remove any links that currently exist in git hooks
    rval |= call(("find %s/.git/hooks -type l -exec rm {} ; " % (
        proj_root)).split())
    rval |= call((("find %s/.githooks -type f -exec "
                   "ln -sf {} %s/.git/hooks/ ; ") % (
        proj_root, proj_root)).split())
    # set the git hooks directory to the git controlled .githooks
    # Note this only works with new versions of git
    # call("git -C {} config core.hooksPath .githooks".format(
    #    proj_root).split())
    return rval


def add_custom_git_config_options():
    """
    This adds configuration options to git
    """
    commands = ["git config --local include.path ../.gitconfig"]

    for command in commands:
        print(command)
        call(command.split())


def configure_git():
    """
    This performs operations that will configure git.
    """
    # link_hooks() TODO
    add_custom_git_config_options()


if __name__ == "__main__":
    sys.exit(configure_git())
