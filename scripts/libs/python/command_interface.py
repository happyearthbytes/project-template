
#!/usr/bin/env python3
import subprocess


class CommandInterface:
    def __init__(self) -> None:
        self.print = False
        self._ret_code = 1

    def cmd(self, cmd_str, shell=True, outfile=None, always_pass=False):
        """ Run a single subprocess command """
        self._ret_code = 1
        if shell:
            cmd_arg = cmd_str
        else:
            cmd_arg = cmd_str.split(" ")

        if outfile:
            outfile = open(outfile, "w+")

        # Note that this subprocess call need to have path modifications
        print(f"> {cmd_arg}")
        if not self.print:
            self._ret_code = subprocess.call(
                cmd_arg, shell=shell, stdout=outfile, stderr=outfile)
        else:
            self._ret_code = 0

        # Force a passing return status
        if always_pass:
            self._ret_code = 0

        # Update the ret_code if it is an error code
        if self._ret_code != 0:
            self.ret_code = self._ret_code

        return self._ret_code
