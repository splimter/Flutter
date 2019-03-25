# Basic App

### main.dart

`runApp(App())` Inflate the given widget and attach it to the screen.

### app.dart

```javascript
class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}
```

`StatefulWidget` Stateful widgets are useful when the part of the user interface you are describing can change dynamically.

`createState()` Creates the mutable state for this widget at a given location in the tree.


```javascript
void fetchImg() async{
    counter++;
    var res = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imgMod = ImgMod.fromJson(json.decode(res.body));

    setState(() {
      img.add(imgMod);
    });
}
```

`get` Sends an HTTP GET request with the given headers to the given URL.

	
`json.decode` Converts data in JSON format into a data object.

### Img_mod.dart

It contain the image model.

`Map<String, dynamic>` A collection of key/value pairs, from which you retrieve a value using its associated key.

### ImgList.dart

It contain the style of how the image and title will be displayed.

`ListView.builder` Creates a scrollable, linear array of widgets that are created on demand.

* The `itemCount` will define the number of iamge on the ListVeiw.

* The `itemBuilder` will create the image with it border and title by calling the `buildImg` function.

`Image.network` Creates a widget that displays an ImageStream obtained from the network.
