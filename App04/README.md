# Animation

### cat.dart

This is a custom Widget that contain the cat imag.

### home.dart

```javascript
Animation<double> catAnim;
AnimationController catControl;

Animation<double> boxAnim;
AnimationController boxControl;
```

We defin the `initState` to initilize the animation state.

By calling the Ctor we set the duration of the animation.

```javascript
catControl = AnimationController(
	duration: Duration(seconds: 1),
	vsync: this,
);

boxControl = AnimationController(
	duration: Duration(milliseconds: 300),
	vsync: this,
);
```

The `Tween` will draw the path that the animation will go throught, it will use `parent` to define the duration, and use `curve` to set the how the curve will behaive.
```javascript
catAnim = Tween(begin: -35.0, end: -80.0
	).animate(
	CurvedAnimation(parent: catControl,curve: Curves.easeIn
	)
);

boxAnim = Tween(begin: pi * 0.6, end: pi * 0.65
	).animate(
	CurvedAnimation(parent: boxControl, curve: Curves.easeInOut
	)
);
```


an `Animation<double>` object can Listen to statue and change it state.
```javascript
boxAnim.addStatusListener((status) {
	if (status == AnimationStatus.completed)
		boxControl.reverse();
	else if (status == AnimationStatus.dismissed)
		boxControl.forward();
});
```
