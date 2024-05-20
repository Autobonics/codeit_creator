Use this package to add your own widgets and categories to codeit creator.

## Getting started

Inorder to add a new category, follow the steps below.

1. Add a folder in lib/presentation with the name of the category.
    - lets say we are creating a category called Sensors. Then we add the folder `sensors` in lib/presentation.
2. Add a file called `categoryname_category.dart` which returns a `CreatorCategory` widget.
    - in our example, we have to create a file called `sensors_category.dart`.
3. Add widget for each functionality inside the folder /lib/presenstaion/category_name/elements.
4. Each widget requires two files each returning `CreatorCanvasElement` and another one that will return the actual UI that need to be rendered.

## Usage

Use the /example to run and test your widgets.


## Additional information

Pull requests are welcome.
