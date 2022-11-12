# YAPL

## Example

```python
def my_func(input_arg_message: str = "not set") -> (return_code: int = 0):
    new_variable: int = print(print_string = input_arg_message)
    return_code = new_variable
    return(return_value = return_code)
my_func(input_arg_message = "Hello World!")
return(return_value = 0)
```

## Level 1 - this compiles to source code of any other language

```yaml

# func my_func(str input_arg_message = "not set") -> (int return_code = 0)
{
  command: declare,
  settings: {
    name: my_func,
    type: func
  },
  command: assign,
  settings: {
    name: my_func,
    value:
    {
      in: [
        {
          command: declare,
          settings:
          {
            name: input_arg_message,
            type: str,
            value: "not set"
          }
        }
      ],
      out: [
        {
          command: declare,
          settings:
          {
            name: return_code,
            type: int,
            value: 0
          }
        }
      ],
      body: [
        # int new_variable = print(...)
        {
          command: declare,
          settings:
          {
            name: new_variable,
            type: int,
            value:
            # print(print_string = input_arg_message)
            {
              command: run,
              settings:
              {
                name: print,
                in: [
                  {
                    name: print_string,
                    value: input_arg_message
                  }
                ]
              }
            }
          }
        },
        # return_code = new_variable
        {
          command: assign,
          settings:
          {
            name: return_code,
            value: new_variable
          }
        }
        # return(return_value = return_code)
        {
          command: run,
          settings:
          {
            name: return,
            in: [
              name: return_value,
              value: return_code
            ]
          }
        }
      ]
    }
  }
},
# my_func(input_arg_message = "Hello World!")
{
  command: run,
  settings:
  {
    name: my_func,
    in: [
      {
        name: input_arg_message,
        value: "Hello World!"
      }
    ]
  }
},
# return(return_value = 0)
{
  command: run,
  settings:
  {
    name: return,
    in: [
      name: return_value,
      value: 0
    ]
  }
}
```

## Level 2 - this compiles to Level 1

* Unwraps command and settings

```yaml
# func my_func(str input_arg_message = "not set") -> (int return_code = 0)
{ # ** DECLARE **
  # we implicitly know this to be a declare command
  # because `type` is provided.
  # `value` also implicitly performs `assign` command
  name: my_func,
  type: func
},
{ # ** ASSIGN **
  # We implicitly know this to be an assign command
  # because `value` is provided. raises error if
  # name is not in scoped namespace
  name: my_func,
  value:
  {
    in: [
      { # ** DECLARE **
        name: input_arg_message,
        type: str
      },
      { # ** ASSIGN **
        name: input_arg_message,
        value: "not set"
      }
    ],
    out: [
      { # ** DECLARE **
        name: return_code,
        type: int
      },
      { # ** ASSIGN **
        name: return_code,
        value: 0
      }
    ],
    body: [
      # int new_variable = print(...)
      { # **DECLARE**
        name: new_variable,
        type: int
      },
      { # ** ASSIGN **
        name: new_variable,
        value:
        # print(print_string = input_arg_message)
        { # ** RUN **
          # We implicitly know this to be a run command
          # because 'in' is provided
          name: print,
          in: [
            {
              name: print_string,
              value: input_arg_message
            }
          ]
        }
      },
      # return_code = new_variable
      { # ** ASSIGN **
        name: return_code,
        value: new_variable
      },
      # return(return_value = return_code)
      { # ** RUN **
        name: return,
        in: [
          name: return_value,
          value: return_code
        ]
      }
    ]
  }
},
# my_func(print_string = "Hello World!")
{ # ** RUN **
  name: my_func,
  in: [
    {
      name: input_arg_message,
      value: "Hello World!"
    }
  ]
},
# return(return_value = 0)
{ # ** RUN **
  name: return,
  in: [
    name: return_value,
    value: 0
  ]
}
```

## Level 3 - this compiles to Level 2

* combine name & type fields for declare
* combine name & value for assign
* combine name & in for run

```yaml
# func my_func(str input_arg_message = "not set") -> (int return_code = 0)
{ # ** DECLARE **
  # If the first argument is not in scoped namespace,
  # and the second argument is a type, then this is
  # implicitly known to be a declare
  my_func: func
},
{ # ** ASSIGN **
  # If the first argument is in the scoped namespace,
  # We implicitly know this to be an assign operation
  my_func:
  {
    in: [
      { # ** DECLARE **
        input_arg_message: str
      },
      { # ** ASSIGN **
        input_arg_message: "not set"
      }
    ],
    out: [
      { # ** DECLARE **
        return_code: int
      },
      { # ** ASSIGN **
        return_code: 0
      }
    ],
    body: [
      # int new_variable = print(...)
      { # **DECLARE**
        new_variable: int
      },
      { # ** ASSIGN **
        # print(print_string = input_arg_message)
        new_variable:
        { # ** RUN **
          # If the first argument is run, we know
          # this to be a run operation
          run: print,
          value: [
            {
              print_string: input_arg_message
            }
          ]
        }
      },
      # return_code = new_variable
      { # ** ASSIGN **
        return_code: new_variable
      },
      # return(return_value = return_code)
      { # ** RUN **
        run: return,
        value: [
          return_value: return_code
        ]
      }
    ]
  }
},
# my_func(print_string = "Hello World!")
{ # ** RUN **
  run: my_func,
  value: [
    {
      input_arg_message: "Hello World!"
    }
  ]
},
# return(return_value = 0)
{ # ** RUN **
  run: return,
  value: [
    return_value: 0
  ]
}
```

## Level 4 - this compiles to Level 3

* combine declare and assigns

```yaml
# func my_func(str input_arg_message = "not set") -> (int return_code = 0)
{ # ** DECLARE & ASSIGN **
  # If there is a valid declare pattern, and a value
  # field. we know this is a declare and assign
  my_func: func,
  value:
  {
    in: [
      { # ** DECLARE & ASSIGN **
        input_arg_message: str,
        value: "not set"
      }
    ],
    out: [
      { # ** DECLARE & ASSIGN **
        return_code: int,
        value: 0
      }
    ],
    body: [
      # int new_variable = print(...)
      { # ** DECLARE & ASSIGN **
        new_variable: int,
        value:
        { # ** RUN **
          # If the first argument is run, we know
          # this to be a run operation
          run: print,
          value: [
            {
              print_string: input_arg_message
            }
          ]
        }
      },
      # return_code = new_variable
      { # ** ASSIGN **
        return_code: new_variable
      },
      # return(return_value = return_code)
      { # ** RUN **
        run: return,
        value: [
          return_value: return_code
        ]
      }
    ]
  }
},
# my_func(print_string = "Hello World!")
{ # ** RUN **
  run: my_func,
  value: [
    {
      input_arg_message: "Hello World!"
    }
  ]
},
# return(return_value = 0)
{ # ** RUN **
  run: return,
  value: [
    return_value: 0
  ]
}
```

### Level 4 - compact yaml

```yaml
# func my_func(str input_arg_message = "not set") -> (int return_code = 0)
# ** DECLARE & ASSIGN **
- my_func: func
  value:
    in:
    # ** DECLARE & ASSIGN **
    - input_arg_message: str
      value: "not set"
    out:
    # ** DECLARE & ASSIGN **
    - return_code: int
      value: 0
    body:
    # int new_variable = print(...)
    # ** DECLARE & ASSIGN **
    - new_variable: int
      value:
        # ** RUN **
        run: print
        value:
        - print_string: input_arg_message
    # return_code = new_variable
    # ** ASSIGN **
    - return_code: new_variable
    # return(return_value = return_code)
    # ** RUN **
    - run: return
      value:
      - return_value: return_code
# my_func(print_string = "Hello World!")
# ** RUN **
- run: my_func
  value:
  - input_arg_message: "Hello World!"
# return(return_value = 0)
# ** RUN **
- run: return
  value:
  - return_value: 0
```

### Level 4 - more compact

```yaml
- my_func: func
  value:
    in:
    - input_arg_message: str
      value: "not set"
    out:
    - return_code: int
      value: 0
    body:
    - new_variable: int
      value:
        run: print
        value: [{print_string: input_arg_message}]
    - return_code: new_variable
    - run: return
      value: [{return_value: return_code}]
- run: my_func
  value: [{input_arg_message: "Hello World!"}]
- run: return
  value: [{return_value: 0}]
```

### Level 4 - more more compact (valid yaml)

```yaml
- my_func: func
  value:
    in: [{input_arg_message: str, value: "not set"}]
    out: [{return_code: int, value: 0}]
    body:
    - {new_variable: int,
       value: {run: print, value: [{print_string: input_arg_message}]}}
    - {return_code: new_variable}
    - {run: return, value: [{return_value: return_code}]}
- {run: my_func, value: [{input_arg_message: "Hello World!"}]}
- {run: return, value: [{return_value: 0}]}
```

### Level 5 - compile to yapl (modified subset of python)

* convert to `yapl`

```python
# my_func: func
#   value:
#     in: [{input_arg_message: str, value: "not set"}]
#     out: [{return_code: int, value: 0}]
#     body:
def my_func(input_arg_message: str = "not set") -> (return_code: int = 0):
    # - {new_variable: int,
    #    value: {run: print, value: [{print_string: input_arg_message}]}}
    new_variable: int = print(print_string = input_arg_message)
    # - return_code: new_variable
    return_code = new_variable
    # - {run: return, value: [{return_value: return_code}]}
    return(return_value = return_code)
# {run: my_func, value: [{input_arg_message: "Hello World!"}]}
my_func(input_arg_message = "Hello World!")
# {run: return, value: [{return_value: 0}]}
return(return_value = 0)
```
