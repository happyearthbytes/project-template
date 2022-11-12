#!/usr/bin/env python3
import sys
from dataclasses import dataclass


@dataclass
class my_func_return:
  return_code: int = 0

# def my_func(input_arg_message: str = "not set") -> (return_code: int = 0):
def my_func(input_arg_message: str = "not set", return_code = None) -> my_func_return:
  return_code = return_code if return_code else my_func_return()
  # new_variable: int = print(print_string = input_arg_message)
  new_variable: None = print(input_arg_message)
  return_code = new_variable
  # return(return_value = return_code)
  return(return_code)

my_func(input_arg_message = "Hello World!")

# return(return_value = 0)
sys.exit(0)
