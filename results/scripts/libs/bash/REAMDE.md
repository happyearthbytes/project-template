# Conventions:

## VARIABLES

```
__VARIABLE_NAME : for a library provided variable - library namespace - don't modify in scripts
_VARIABLE_NAME : for a locally defined variable - local namespace - don't reference in libraries
g_VARIABLE_NAME : global variables - defaults defined in libs - override in scripts
VARIABLE_NAME : don't define these in scripts - shell namespace
local variable_name : function namespace
```

## Functions

```
__function_name() : for a library provided function - shared namespace
_function_name() : for a locally defined function - local namespace
g_function_name : global function - for callback support - defaults defined in libs - override in scripts 
function_name() : don't define these in scripts - shell namespace
```

