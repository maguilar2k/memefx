# How to configure an Images Accordion #

This component allows you to create an animated set of images. It can be use to display pictures or as a visual menu. You can bind functions to the images (on Enter, on Press and on Exit the accordion). Check the [available options for this component](accordOptions.md)

# Details #

To setup an image accordion you just need to type something like this:
```
var accordion = ImagesAccordion{

    width: 650, height: 350,


    onAccordionExited: function() {
        println("EXITED");
    }

    images: [

        ImageItem {
            id: "moais",
            caption: "Moais"
            image: Image { url: "{__DIR__}moais.jpg" }
            message: "Easter Island (Rapa Nui) is a Polynesian island in the "
                     "southeastern Pacific Ocean, The island is a special "
                     "territory of Chile. Easter Island is famous  for its "
                     "monumental statues, called moai."
            messageArea: Rectangle2D { minX:30, minY:253, width:350, height:87 }
            // item events
            onMouseEntered: enter
            onMousePressed: click
        },

        ImageItem {

        ...

        },

    ]
};
```
Now, you can add the functions called by the items events:
```
function enter(image:ImageItem) {
    println("{image.id} entered");
}

function click(image:ImageItem) {
    println("{image.id} pressed");
}
```
Finally, you add the component to the scene:
```
Stage {
    scene: Scene {
        content: [
            accordion,
        ]
    }
}
```
The function associated to `onAccordionExited` will be executed when the mouse leaves the accordion control.