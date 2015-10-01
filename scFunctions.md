# Functions #


---


**public function persistStage()**

> Stores in local file (or using the Java Web Start persistence service) the position and size of the window.


---


**public function move(to:Integer)**

> Place window at the specified location.

  * to     Combination of [location constants](scPositioning.md)


---


**public function move(px:Number, py:Number)**

> Place window at the specified location.

  * posx Horizontal coordinate for the window
  * posy Vertical coordinate for the window


---


**public function animateTo(dx:Number, dy:Number)**

> Slides window to the specified screen coordinate.

  * dx     Horizontal coordinate for the window
  * dy     Vertical coordinate for the window


---


**public function animateToBorder(corner:Integer, dx:Number, dy:Number)**

> Slides window to the specified distance from screen borders.

  * corner [Location](scPositioning.md) used as reference for the destination of the window
  * dx     Horizontal distance to the location
  * dy     Vertical distance to the location


---


**public function maximize()**

> Maximize to screen size.


---


**public function setMaxWidth()**

> Set window width to screen width.


---


**public function setMaxHeight()**

> Set window height to screen height.


---


**public function recoverInitialWindow()**

> Recovers initial position/size of the window.


---


**public function recoverInitialPos()**

> Recovers initial position of the window.


---


**public function recoverInitialSize()**

> Recovers initial size of the window.


---
