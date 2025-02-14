## 0.2.2

### New features

* Add `key_column_name` to configuration for aliasing `circuit_switches.key`.

### Changes

* Declare dependent on ActiveSupport instead of implicitly dependent.

## 0.2.1

### New features

* Add `initially_closed` option to `run` and `open?`.
* Add `key` argument for easy handling for human more than caller.  
To migrate, run next.

```
rails generate circuit_switch:migration circuit_switch add_key
rails db:migrate
```

### Changes

* Modify log level from warn to info when default value for `close_if_reach_limit` is used.
* Suppress warning that ivar is not initialized.

## 0.2.0

### Breaking Changes

* Modify default value of `CircuitSwitch.run` argument `close_if_reach_limit` from true to false.

## 0.1.2

* Modify `CircuitSwitch.open?` receives same arguments as `CircuitSwitch.run`

## 0.1.1

* Fix bug due_date is not set.
