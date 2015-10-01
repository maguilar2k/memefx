# Set value #

The main purpose of this component is to display a graphical representation of a value. So, it's vital to handle a couple of concepts about assigning values to the gauge control.

  * You assign a value to the gauge using the `value` parameter in the gauge definition. You will probably provide this value using a bind statement, to make it variable:

```
    value: bind myValue
```

Previous to this value assignment you should consider at least two things:

  * The initial value in the gauge at the moment of the new assignment
  * The speed for the needle to go from the current or initial value to the new value provided by you

If you don't assign an specific initial value to your gauge, the component will assume the minimum value allowed for the gauge as the initial value.

You can assign a different initial value including the following line into the gauge definition:

```
    initialValue: 5.0
```

On the other hand, if you don't specify a speed for the needle rotation, the component will assume the FAST speed, which doesn't mean an instantaneous refresh for the gauge needle. There are two other options faster that this one: FASTEST and INMEDIATE.

The FASTEST option provides a speedier rotation for the needle, while the INMEDIATE setting implies an instantaneous jump of the needle, from the current position to the new position corresponding to the value assigned to the gauge.

You can provide a different rotational speed for the gauge control, including the following line into the gauge definition:
```
    speed: Gauge.SLOW
```