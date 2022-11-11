#!/usr/bin/env python3
"""
setup tools
"""
import argparse
import sys

from common import Common

common = Common()

sys.exit()
# 1. arg parse

# 2. use arg to register function on the selected environment type

# 3. run setup on that environment type

# 4. install vscode repo (for each environment)

# 5. install make/podman/code

# 6. cleanup vscode repo


class SetupPy:
  """ simple interface to run basic operations """

  def __init__(self) -> None:
    self.options = None
    self.ret_code = 0
    self.version = "1.0.0"

  def __enter__(self) -> None:
    self.parse_args()
    return self

  def __exit__(self, type, value, traceback) -> None:
    self.return_code()

  def parse_args(self):
    """ Parse command line args """
    self.parser = argparse.ArgumentParser(
      description=(
        "The purpose of this command is to provide a convenience "
        "interface to perform basic capabilities related to "
        "interacting with this repository"),
      formatter_class=argparse.RawTextHelpFormatter)

    self.parser.add_argument(
      "--version", action="version",
      version="%(prog)s " + self.version)
    self.parser.add_argument(
        "-v","--verbose", action="store_true",
        help="Run in verbose mode")
    setup_types = ["local", "bootstrap", "cicd", "offline"]
    self.parser.add_argument(
        "--type", choices=setup_types, default="local",
        help="The setup type")

    # Default is help
    if len(sys.argv) == 1:
        sys.argv.append("-h")
    # Remove filename from the start of args
    args = list(sys.argv[1:])

    self.options = self.parser.parse_args(args)

  def install_ide(self) -> None:
    """" install an IDE """
    print("did thing")
  def install_basics(self) -> None:
    """" Install basic packages """
    print("did thing")

  def start(self) -> None:
    """ Define argparser commands """
    self.install_ide()
    self.install_basics()

  def return_code(self) -> None:
      """ Return the return code of the operations """
      return sys.exit(self.ret_code)

if __name__ == "__main__":
    with SetupPy() as run:
      run.start()
