- return of decirator is a `Function`
  

```python
## Exp.1.
@decorator
def func():
    pass
## equal to 
func = decorator(func)
```

- decorator with args
  > means ` a function that returns a wrapper function`

```python
from functools import wraps

def logit(logfile='out.log'):
    def logging_decorator(func):
        @wraps(func)
        def wrapped_function(*args, **kwargs):
            log_string = func.__name__ + " was called"
            print(log_string)
            # Open the logfile and append
            with open(logfile, 'a') as opened_file:
                # Now we log to the specified logfile
                opened_file.write(log_string + '\n')
        return wrapped_function
    return logging_decorator
```

## Refrences

1. [pythontips](http://book.pythontips.com/en/latest/decorators.html#decorators-with-arguments)