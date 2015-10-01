# Options #

**Accordion control width**
  * width: 500.0

**Accordion control height**
  * height: 400.0

**Accordion orientation**
  * orientation: `ImagesAccordion.HORIZONTAL`

**Accordion mouse cursor**
  * cursor: `Cursor.DEFAULT`

**Minimum width for images (while image selected)**
  * minWidth: 40.0

**Color for separation line (between images)**
  * lineColor : Color.WHITE

**Opacity for separation line (between images)**
  * lineOpacity: 0.5

**Width for separation line (between images)**
  * lineWidth: 1.0

**Image caption text color**
  * captionColor: Color.WHITE

**Image caption text font**
  * captionFont: Font { size: 24 }

**Time to hide main caption**
  * timeToHideCaption: 1s

**Time to show main caption**
  * timeToShowCaption: 1s

**Time to expand selected image**
  * timeToExpand: 0.5s

**Time to show extended message**
  * timeToMessage: 1s

**Time to fade in extended message**
  * timeFadeInMessage: 0.5s

**Extended message border space**
  * messageBorder: 10.0

**Extended message corner arc**
  * messageArc: 10.0

**Time to highlight (make brighter) the selected image**
  * timeToNormalLevel: 0.5s

**Normal level for select image**
  * normalLevel: 0.0

**Time to dark (make darker) the unselected images**
  * timeToDarkLevel: 0.5s

**Dark level for unselect images**
  * darkLevel: -0.5

**Interpolator applied on items movement**
  * interpolator: `SpringInterpolator` { mass: 2.0, bounce: true, stiffness: 10 }

**Time to detect mouse exiting the accordion**
  * timeOnExit: 0.5s

**Deselect item on exit**
  * hideOnExit: true

**Function associated to mouse leaving the accordion**
  * onAccordionExited: function():Void

**Select item on mouse pressed**
  * selectOnPressed: false

**Image items for the accordion**
  * images: `ImageItem[]`

Check the [Accordion Functions](accordFunctions.md)


---


# Accordion Items #

**Item id**
  * id: String

**Item image**
  * image: Image

**Caption text**
  * caption: String

**Extended message displayed over the image (con include basic HTML tags)**
  * message: String

**Rectangular area to display the message**
  * messageArea: Rectangle2D

**Background color for the message area**
  * messageAreaColor: Color.BLACK

**Opacity for the background of the message area**
  * messageAreaOpacity: 0.4

**Text color for the extended message**
  * messageColor: Color.WHITE

**Text font for the extended message**
  * messageFont: Font { size: 14 }

**Function associated to click over the image item**
  * onMousePressed: function(`ImageItem`)

**Function associated to mouse over the image item**
  * onMouseEntered: function(`ImageItem`)

**Function associated to click over a link in the extended description**
  * onLinkPressed: function(String)