
#!/usr/bin/env python3

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
