#!/bin/env python3
"""
The purpose of this file is to provide a convenience interface to perform
basic capabilities related to interacting with this repository
"""
import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path


class MakePy(object):  # pylint: disable=useless-object-inheritance
    """ simple interface to run basic operations """

    def __init__(self):

        self.options = None
        # Default to pass
        self.ret_code = 0

        self.parser = argparse.ArgumentParser(
            description=(
                "The purpose of this command is to provide a convenience "
                "interface to perform basic capabilities related to "
                "interacting with this repository"),
            formatter_class=argparse.RawTextHelpFormatter)

        self.version = "1.0.0"
        self.parser.add_argument('--version', action='version',
                                 version='%(prog)s ' + self.version)

        parser_command = self.parser.add_argument_group("Target Commands")
        parser_command_exc = parser_command.add_mutually_exclusive_group()
        parser_command_exc.add_argument(
            "--build", action="store_true",
            help="Build the target")
        parser_command_exc.add_argument(
            "--package", action="store_true",
            help="Package the target")
        parser_command_exc.add_argument(
            "--package_source", action="store_true",
            help="Package source of the target")
        parser_command_exc.add_argument(
            "--cov-build", action="store_true",
            help="Perform a cov-build of the target")
        parser_command_exc.add_argument(
            "--install", action="store_true",
            help="Install the target")
        parser_command_exc.add_argument(
            "--test", action="store_true",
            help="Test the target")
        parser_command_exc.add_argument(
            "--mem_test", action="store_true",
            help="Memory test the target")
        parser_command_exc.add_argument(
            "--verify", action="store_true",
            help="Verify the target")
        parser_command_exc.add_argument(
            "--scan", action="store_true",
            help="Perform scans on the target")
        parser_command_exc.add_argument(
            "--docs", action="store_true",
            help="Generate documents for the target")
        parser_command_exc.add_argument(
            "--start", action="store_true",
            help="Start the target")
        parser_command_exc.add_argument(
            "--stop", action="store_true",
            help="Stop the target")

        parser_general = self.parser.add_argument_group("General Commands")
        parser_general_exc = parser_general.add_mutually_exclusive_group()
        parser_general_exc.add_argument(
            "--setup", action="store_true",
            help="Perform local environment setup commands")
        parser_general_exc.add_argument(
            "--check", action="store_true",
            help="Perform local environment checks")
        parser_general_exc.add_argument(
            "--list", action="store_true",
            help="List build targets")
        parser_general_exc.add_argument(
            "--configure", action="store_true",
            help="Configure build targets")
        parser_general_exc.add_argument(
            "--print_scr", action="store_true",
            help="Print the SCR of the branch")
        parser_general_exc.add_argument(
            "--verify_scr_open", action="store_true",
            help="Verify if the current SCR is open")
        parser_general_exc.add_argument(
            "--verify_scr_complete", action="store_true",
            help="Verify if the current SCR is complete")
        parser_general_exc.add_argument(
            "--ci_start", action="store_true",
            help="Apply a Continuous Integration Tag")
        parser_general_exc.add_argument(
            "--ci_stop", action="store_true",
            help="Remove a Continuous Integration Tag")
        parser_general_exc.add_argument(
            "--clean", action="store_true",
            help="Clean the workspace for the local build context")
        parser_general_exc.add_argument(
            "--clean_all", action="store_true",
            help="Clean the workspace for all builds")
        parser_general_exc.add_argument(
            "--purge", action="store_true",
            help="Purge the local workspace")

        self.parser.add_argument(
            "-d", "--docker", action="store_true",
            help="Run the command in a container")
        self.parser.add_argument(
            "--build_dir", default="build",
            help="The build directory")
        self.parser.add_argument(
            "--debug_print", action="store_true",
            help="Enable debug printing")
        self.parser.add_argument(
            "--build_type", choices=["Debug", "Release"], default="Debug",
            help="The build type")
        self.parser.add_argument(
            "--jobs",
            help="The number of jobs")
        self.parser.add_argument(
            "--credentials", nargs=2,
            help="Login credentials. Never save credentials as plaintext")
        self.parser.add_argument(
            "--print", action="store_true",
            help="Print commands, but don't run them")
        self.parser.add_argument(
            "--cmake", default="cmake3",
            help="The cmake executable")
        self.parser.add_argument(
            "--python", default="python",
            help="The python executable")

        # The positional target argument
        self.parser.add_argument(
            "target", nargs="?",
            help="The target to build. Set to 'all' to build all targets.")

    def start(self):
        """ Define argparser commands  """

        # Default is help
        if len(sys.argv) == 1:
            sys.argv.append("-h")

        # Remove 'make.py' from the start of args
        args = list(sys.argv[1:])

        self.options = self.parser.parse_args(args)

        self.print = self.options.print
        self.build_dir = self.options.build_dir
        self.build_type = self.options.build_type
        self.credentials = self.options.credentials
        self.docker = self.options.docker
        self.cmake = self.options.cmake
        self.python = self.options.python
        self.jobs = "-j%s" % (self.options.jobs) if self.options.jobs else ""
        self.cmake_build = ("%s --build \"%s\" --target" %
                            (self.cmake, self.build_dir))
        # target will be everything on default or all
        self.target = "" if not self.options.target or self.options.target == "all" else self.options.target

        # Run this command in a docker container
        if self.docker:
            self._run_docker()

        command_map = {
            "build": {"type": "target", "arg": "build_group"},
            "cov-build": {"type": "target", "arg": "--"},
            "package": {"type": "target", "arg": "package"},
            "package_source": {"type": "target", "arg": "package_source"},
            "test": {"type": "target", "arg": "test"},
            "mem_test": {"type": "target", "arg": "--"},
            "all": {"type": "target", "arg": "all"},
            "start": {"type": "target", "arg": "start_group"},
            "stop": {"type": "target", "arg": "stop_group"},
            "install": {"type": "target", "arg": "install"},
            "verify": {"type": "target", "arg": "verify_group"},
            "docs": {"type": "target", "arg": "docs_group"},
            "scan": {"type": "target", "arg": "scan_group"},
            "setup": {"type": "function", "arg": self._setup},
            "check": {"type": "function", "arg": self._check},
            "print_scr": {"type": "function", "arg": self._print_scr},
            "list": {"type": "function", "arg": self._list},
            "clean": {"type": "function", "arg": self._clean},
            "clean_all": {"type": "function", "arg": self._clean},
            "purge": {"type": "function", "arg": self._purge},
            "verify_scr_open": {"type": "function", "arg": self._verify_scr_open},
            "verify_scr_complete": {"type": "function", "arg": self._verify_scr_complete},
            "ci_start": {"type": "function", "arg": self._ci_start},
            "ci_stop": {"type": "function", "arg": self._ci_stop},
            "configure": {"type": "function", "arg": self._configure},
        }

        # Get all selected commands that are in the command map
        command = [arg for arg in self.options.__dict__
                   if self.options.__dict__[arg] == True and arg in command_map]

        if self.options.debug_print:
            self.debug_print = "--log-level=debug"
        else:
            self.debug_print = ""

        # commands that require other arguments to be read first
        self.cmake_flags = ("%s %s \"-DTARGETS=%s\" \"-DCMAKE_INSTALL_PREFIX=%s\" "
                            "\"-DCMAKE_BUILD_TYPE:STRING=%s\" \"-H.\" -B\"%s\"") % (
            self.cmake, self.debug_print, self.target, "",
            self.build_type, self.build_dir)

        # Iterate for each command
        for this_command in command:
            mapped_command = command_map[this_command]
            if mapped_command["type"] == "target":
                # check to make sure that target was defined
                # Using original option in order to ensure that default doesn't run all
                if not self.options.target:
                    self.parser.error(
                        "Target needs to be defined")

                # Using original option in order to check that all was explicit
                if (self.options.target != "all") and (not Path(self.target).exists()):
                    self.parser.error(
                        "Target doesn't exist: %s" % (self.target))

                self._configure()
                self._cmake_build(this_command, mapped_command["arg"])
            elif mapped_command["type"] == "function":
                mapped_command["arg"]()

    def _run_docker(self):
        """ run the command in a docker container """
        docker_cmd = "docker-compose -f environment/build_image/docker-compose.yml run --user '%s:%s' --rm build_environment" % (
            os.getuid(), os.getgid())

        # remove the docker command from the arguments
        new_arg = sys.argv
        items = ['-d', '--docker']
        for item in items:
            if item in new_arg:
                new_arg.remove(item)

        # now modify the make command to define the build directory
        add_flags = ["--build_dir", "/build_output/build_docker"]
        new_arg.insert(1, add_flags[1])
        new_arg.insert(1, add_flags[0])

        new_cmd = docker_cmd + " " + " ".join(new_arg)
        self.cmd(new_cmd)

        # If we are running docker, we just want to exit
        sys.exit(self.ret_code)

    def _setup(self):
        """ perform operations to configure your local environment """
        self.cmd("%s ./scripts/bashrc/install.sh" % (self.python))
        if not Path('.git/hooks/githooks_installed').exists():
            self.cmd("%s ./scripts/configure_git.py" % (self.python))
        self.cmd("%s ./scripts/install_tools.sh" % (self.python))

    def _check(self):
        """ Check the status of this build machine """
        self.cmd("%s ./scripts/check_machine.sh" % (self.python))

    def _print_scr(self):
        """ prints data from the associated SCR """
        if not self.credentials:
            self.parser.error("CREDENTIALS required")
        self.cmd("%s ./scripts/jira_api/get_jira_data.py -c %s %s" %
                (self.python, self.credentials[0], self.credentials[1]))

    def _verify_scr_open(self):
        """ veriy the scr is open """
        if not self.credentials:
            self.parser.error("CREDENTIALS required")
        self.cmd(
            "%s ./scripts/jira_api/get_scr_status.py -c %s %s -v 'in work' in review' 'in verification'" %
            (self.python, self.credentials[0], self.credentials[1]))

    def _verify_scr_complete(self):
        """ veriy the scr is complete """
        if not self.credentials:
            self.parser.error("CREDENTIALS required")
        self.cmd(
            "%s ./scripts/jira_api/get_scr_status.py -c %s %s -v 'completed' 'closed'" %
            (self.python, self.credentials[0], self.credentials[1]))

    def _ci_start(self):
        """ Start CI builds on this commit """
        self.cmd("%s ./scripts/ci_api.py --ci start" % (self.python))

    def _ci_stop(self):
        """ Stop CI builds on this commit """
        self.cmd("%s ./scripts/ci_api.py --ci stop" % (self.python))

    def _list(self):
        """ List all build targets """
        self.cmd("%s %s" %
                 (self.cmake_build, "help"))
        self.cmd("%s %s -- %s" %
                 (self.cmake_build, "list_install_components", self.jobs))

    def _clean(self):
        """ Remove build files from the build directory """
        # first need to configure for this target, so that it can identify artifacts to clean
        if not (Path(self.build_dir) / "CMakeFiles").is_dir():
            print("Incomplete build directory")
            return

        # When we clean all we generate makefiles for all targets, otherwise we use
        # whatever was previously generated
        if self.options.clean_all:
            self.cmd(self.cmake_flags)

        self.cmd("%s %s" %
                 (self.cmake_build, "clean"), always_pass=True)
        files_to_remove = [Path(self.build_dir) / "Makefile",
                           Path(self.build_dir) / ".target"
                           ] + list(Path(self.build_dir).glob("*.target"))
        for this_file in files_to_remove:
            if os.path.exists(this_file):
                print("Removing", this_file)
                os.remove(this_file)

    def _purge(self):
        """ Purge the whole project. This empties the build directory """
        print("Removing", self.build_dir)
        shutil.rmtree(self.build_dir)
        print("Creating", self.build_dir)
        os.mkdir(self.build_dir)

    def dummy(self):
        self.ret_code = -1

    def _configure(self):
        """ perform cmake configuration """
        target_file = "%s/%s.target" % (self.build_dir,
                                        self.target.replace("/", "_"))
        # Only need to reconfigure if the target changed
        if not Path(target_file).exists():
            self.cmd(self.cmake_flags)

            # Remove existing target files
            files_to_remove = ([Path(self.build_dir) / ".target"] +
                               list(Path(self.build_dir).glob("*.target")))
            for this_file in files_to_remove:
                if os.path.exists(this_file):
                    print("Removing", this_file)
                    os.remove(this_file)

            # Create the empty target file
            open(target_file, 'a').close()

    def _cmake_build(self, command_name, build_arg):
        """ """
        command = build_arg
        if command_name == "package":
            command += " ARGS='-V' "
        if command_name == "test":
            self.cmd("%s %s -- %s" %
                     (self.cmake_build, "test_group", self.jobs))
            command += " ARGS='-V' "
        if command_name == "mem_test":
            self.cmd("%s %s -- %s" %
                     (self.cmake_build, "test_group", self.jobs))
            self.cmd("cd %s ctest -j1 --output-on-failure -V -T memcheck ." %
                     (self.build_dir))
            return
        if command_name == "cov-build":
            self.cmd("%s -DCMAKE_CXX_COMPILER=/usr/bin/g++" %
                     (self.cmake_flags))
            self.cmd(
                "cov-build --dir %s --config scripts/coverity/gcc-config.xml make -C build" % (self.build_dir))
            self.cmd("cov-analyze --dir %s" % (self.build_dir))
            return

        else:
            pass
        self.cmd("%s %s -- %s" %
                 (self.cmake_build, command, self.jobs))

    def return_code(self):
        """
        Return the return code of the operations
        """
        return sys.exit(self.ret_code)

    def cmd(self, cmd_str, shell=True, outfile=None, always_pass=False):
        """ Run a single subprocess command """
        if shell:
            cmd_arg = cmd_str
        else:
            cmd_arg = cmd_str.split(" ")

        if outfile:
            outfile = open(outfile, "w+")

        # Note that this subprocess call need to have path modifications
        print("> " + cmd_arg)
        if not self.print:
            ret_code = subprocess.call(
                cmd_arg, shell=shell, stdout=outfile, stderr=outfile)
        else:
            ret_code = 0

        # Force a passing return status
        if always_pass:
            ret_code = 0

        # Update the ret_code if it is an error code
        if ret_code != 0:
            self.ret_code = ret_code


if __name__ == "__main__":
    make = MakePy()
    make.start()
    make.return_code()
