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


class Common:
  def __init__(self) -> None:
    self.set_path_vars()
    self.set_includes()

  def set_path_vars(self) -> None:
    """ set the path vars """
    self.dirs = ProjectDirs()
    self.dirs.base = Path(__file__).parents[2].resolve()
    self.dirs.root = self.dirs.base.parent.resolve()
    self.dirs.scripts = self.dirs.base / "scripts"
    self.dirs.tools = self.dirs.scripts / "tools"
    self.dirs.libs = self.dirs.scripts / "tools"

  def set_includes(self) -> None:
    sys.path.append(self.dirs.libs)
    print(sys.path)
