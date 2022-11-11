#!/usr/bin/env python3
"""
common include
"""
import sys
from dataclasses import dataclass
from pathlib import Path


@dataclass
class ProjectDirs:
  base: Path = Path()
  root: Path = Path()
  scripts: Path = Path()
  tools: Path = Path()
  libs: Path = Path()
  common: Path = Path()
  config: Path = Path()

class Common:
  def __init__(self) -> None:
    self._set_path_vars()
    self._set_includes()
    self._common_includes()

  def _set_path_vars(self) -> None:
    """ set the path vars """
    self.dirs = ProjectDirs()
    self.dirs.base = Path(__file__).parents[2].resolve()
    self.dirs.root = self.dirs.base.parent.resolve()
    self.dirs.scripts = self.dirs.base / "scripts"
    self.dirs.tools = self.dirs.scripts / "tools"
    self.dirs.libs = self.dirs.scripts / "libs" / "python"
    self.dirs.common = self.dirs.libs / "common"
    self.dirs.config = self.dirs.base / "config"

  def _set_includes(self) -> None:
    """ set the include paths """
    sys.path.append(str(self.dirs.common))
    sys.path.append(str(self.dirs.libs))

  def _common_includes(self) -> None:
    """ apply common includes """
    from version import Version
    self._version = Version()

  def import_command_interface(self) -> None:
    """ import command interface """
    from command_interface import CommandInterface
    self._command_interface = CommandInterface()

  @property
  def version(self) -> str:
    return self._version.version

  @property
  def cmd(self) -> str:
    return self._command_interface.cmd
