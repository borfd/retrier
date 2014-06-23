#Retrier

Retry a code block the given number of times.

##Usage

###Basic usage
```ruby
Retrier.new(max_tries: 5) do
  do_something_which_may_fail
end
```

###Specify which exceptions to catch
```ruby
Retrier.new(max_tries: 3, rescue: [MyCustomException, OtherException]) do
...
end
```

###Exception handlers
If supplied with a list of handler functions, `Retrier` will call the handler method. If there isn't a registered handler for the raised exception it will retry the block.
```ruby
handlers = {
  StandardError: (exception) -> {
    do_something_if_standard_error_has_beenraised
  }
}

Retrier.new(handlers: handlers) do
  risky_operation
end
```
