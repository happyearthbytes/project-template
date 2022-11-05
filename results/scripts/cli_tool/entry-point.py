#!/usr/bin/env python3
"""
The purpose of this file is to provide a convenience interface to perform
basic capabilities related to interacting with this repository
"""
import argparse
import subprocess
import sys
from pathlib import Path

class MakePy(object):  # pylint: disable=useless-object-inheritance
    """ simple interface to run basic operations """

    def __init__(self):

        self.options = None
        # Default to pass
        self.ret_code = 0
        self.get_context()
        self.define_argparse()

    def get_context(self):
        """
        Get information about the execution context of this script
        """
        self.current_dir = Path(__file__).parent.resolve()
        self.tool_name = Path(__file__).stem
        self.tools_dir = Path(str(self.current_dir / self.tool_name) + "-tools")
        self.utilities_dir = self.tools_dir / "utilities"

        # Get all the base filenames without extensions in the tool directory
        list_tools_dir = self.tools_dir.glob('*')
        self.tool_names = [tool.stem for tool in list_tools_dir if tool.is_file()]

        # Get all the base filenames without extensions in the utilities directory
        list_utilities_dir = self.utilities_dir.glob('*')
        self.utility_names = [utility.stem for utility in list_utilities_dir if utility.is_file()]

    def define_argparse(self):
        """
        Define the argument parser options
        """
        self.parser = argparse.ArgumentParser(
            prefix_chars='+',
            description=(
                "The purpose of this command is to provide a convenience "
                "interface to perform basic capabilities related to "
                "interacting with this repository"),
            formatter_class=argparse.RawTextHelpFormatter,
            epilog=("Tools:\n  " + '\n  '.join(self.tool_names))
            )

        # Optional Arguments
        self.version = "1.0.0"
        self.parser.add_argument(
            '++version', action='version',
            version='%(prog)s ' + self.version)
        self.parser.add_argument(
            "++verbose", action="store_true",
            help="Enable verboase mode")

        # General Commands
        parser_command = self.parser.add_argument_group("General Commands")
        parser_command.add_argument(
            "++list", action="store_true",
            help="List the available tools")
        parser_command.add_argument(
            "++show", action="store_true",
            help="Show the contents of the selected tool")
        parser_command.add_argument(
            "++dryrun", action="store_true",
            help="Don't actually run a tool, just display what would be run")

        utility_command = self.parser.add_argument_group("Utility Commands")
        utility_command.add_argument(
            "++list_utilities", action="store_true",
            help="List the available utilities")
        utility_command.add_argument(
            "++utility", action="store_true",
            help="Run a utility instead of a tool")

        # Tool Commands
        tool_command = self.parser.add_argument_group("Tool Commands")
        tool_command.add_argument(
            "++none", action="store_true",
            help="Not implemented")

        # The positional arguments
        self.parser.add_argument(
            "tool", nargs='?',
            help="The tool to call.")
        self.parser.add_argument(
            "arguments", nargs="*",
            help="The arguments to pass to the called command.")

    def start(self):
        """
        Define argparser commands
        """

        # Default is help
        if len(sys.argv) == 1:
            sys.argv.append("+h")

        # Remove the name of this script from the start of args
        args = list(sys.argv[1:])

        self.options = self.parser.parse_args(args)

        if(self.options.list):
            self._list_tools()
        if(self.options.list_utilities):
            self._list_utilities()

        if self.options.tool:
            self.execute_command(
                tool = self.options.tool,
                arguments = self.options.arguments,
                is_utility = self.options.utility,
                dryrun = self.options.dryrun,
                show = self.options.show,
                verbose = self.options.verbose)

    def _list_tools(self):
        """
        List all of the availble tools
        """
        print(' '.join(self.tool_names))

    def _list_utilities(self):
        """
        List all of the availble utilities
        """
        print(' '.join(self.utility_names))

    def _check_command(self, tool, is_utility):
        """
        Check the given command with the given arguments
        """
        if is_utility and tool not in self.utility_names:
            self.parser.error((
                "Invalid utility selection: {tool}\n"
                "Valid options:\n\n"
                "{names}").format(tool=tool,
                                names='\n'.join(self.utility_names)))
        elif not is_utility and tool not in self.tool_names:
            self.parser.error((
                "Invalid tool selection: {tool}\n"
                "Valid options:\n\n"
                "{names}").format(tool=tool,
                                names='\n'.join(self.tool_names)))

    def _find_tool(self, tool, is_utility):
        """
        Find the full path to the given tool.
        or None
        """
        check_dir = self.utilities_dir if is_utility else self.tools_dir
        rval = None
        # Allow to match any file extension
        found_tool = list(check_dir.glob(tool+".*"))
        if found_tool:
            rval = found_tool[0]
        else:
            self.parser.error((
                "Unable to find valid tool for: {tool}").format(tool=tool))
        return rval

    def execute_command(self, tool, arguments, is_utility, dryrun, show, verbose):
        """
        Execute the given command with the given arguments
        """
        # Make sure that you can find the tool.
        # Return the full path to the tool you find
        self._check_command(tool, is_utility)
        tool_path = self._find_tool(tool, is_utility)

        if tool_path:
            # Join the tool and arguments into a single command
            command=str(tool_path) + " " + str(' '.join(arguments))

            if show:
                self.show_file_contents(tool_path)
            else:
                # Now run the command
                self.cmd(
                    cmd_str = command,
                    dryrun = dryrun,
                    verbose = verbose)

    def return_code(self):
        """
        Return the return code of the operations
        """
        return sys.exit(self.ret_code)

    def cmd(self, cmd_str, shell=True, outfile=None, always_pass=False, dryrun=False, verbose=False):
        """ Run a single subprocess command """
        if shell:
            cmd_arg = cmd_str
        else:
            cmd_arg = cmd_str.split(" ")

        if outfile:
            outfile = open(outfile, "w+")

        # Note that this subprocess call need to have path modifications
        if verbose or dryrun:
            print("> " + cmd_arg)
        if not dryrun:
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

    def show_file_contents(self, tool_path):
        """ Display the contents of the given file """
        with tool_path.open() as f:
            print(f.read())

if __name__ == "__main__":
    make = MakePy()
    make.start()
    make.return_code()