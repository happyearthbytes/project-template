"""
..
  Author:            Name
  Copyright:         Me
"""
import os
from setuptools import setup, find_packages

from @PY_PACKAGE_NAME@.version import VERSION

NAME = "@PY_PACKAGE_NAME@"
LICENSE = "@LICENSE_FILE@"
SCRIPTS = "@SCRIPTS_LIST@"
README = "@README_FILE@"
SUMMARY = "@SUMMARY@"
AUTHOR = "@AUTHOR@"

# Simple read function
def read(f):
    """ return the contents of a file relative to this one """
    open_file = open(os.path.join(os.path.dirname(__file__), f), encoding="utf-8")
    return str(open_file.read().encode("utf-8"))

setup(
    name=NAME,
    version=VERSION,
    platforms=["any"],
    author=AUTHOR,
    author_email="<author>@place.com",
    description=(SUMMARY),
    license=' '.join(read(LICENSE).strip().split('\n')),
    keywords=["Software", "Engineering"],
    url="<website>",
    packages=find_packages(),
    scripts=[SCRIPTS],
    include_package_data=True,
    long_description=read(README),
    classifiers=[
        "Development Status :: Dev",
    ],
)