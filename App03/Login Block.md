# Login App

## Blocs
### provider.dart

[`updateShouldNotify`](https://docs.flutter.io/flutter/widgets/InheritedWidget/updateShouldNotify.html) Whether the framework should notify widgets that inherit from this widget.

[inheritFromWidgetOfExactType](https://docs.flutter.io/flutter/widgets/BuildContext/inheritFromWidgetOfExactType.html) Obtains the nearest widget of the given type

### Validator

`fromHandlers` will provide `handleData`, it will take the data we want to forward and the **sink** as argument.

`sink` When a destination sink is provided, events that have been passed to the sink will be forwarded to the destination.

if we validate the data we **add** it else we forward it as error **addError**.

### bloc.dart

Both `_email` and `_pwd` are **private** var that captures the latest item that has been added to the controller.

Both `email` and `pwd` will assing the the transformed stream with the **validator**.

Both `changeEmail` and `changePwd` will be used to add event due to Input changes.

the `submit()` will return the data gatherd from the Input.

the `dispose()` will close the sinks.

## screen
### login_screen.dart

Widgets use **StreamBuilders** to change their contents depending on values coming a stream.
