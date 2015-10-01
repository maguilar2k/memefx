# Options #

**HTML Text component width**
  * wrappingWidth:Number=200

**HTML Text content (see [HTML tags supported](txthtmlValidtags.md))**
  * content:String

**component x location**
  * x:Number=0

**component y location**
  * y:Number=0

**interline space**
  * lineSpacing:Number=0.0

**interparagraph space (current line height = 1.0)**
  * paragraphSpacing:Number=0.745;

**Cursor when mouse over a link**
  * linkCursor=Cursor.HAND

**default font attributes**
  * basicTextAttrib = TextAttributes { name:"Arial", size:12.0, color:Color.BLACK, bold:false, italic:false }

**Background color on mouseOver a link (in the current TextHTML control)**
  * onLinkEnteredColor:Color

  * **NOTE**: You can setup a global background color for ALL the mouseOver links across all the TextHTML controls, by setting up:

> TextHTML.mainOnLinkEnteredColor=color;

**Background color on mouseExit a link (in the current TextHTML control)**
  * onLinkExitedColor:Color

  * **NOTE**: You can setup a global background color for ALL the mouseExit links across all the TextHTML controls, by setting up:

> TextHTML.mainOnLinkExitedColor=color;

**function triggered by a click on a link (in the current TextHTML control)**
  * onLinkPressed:function(String)

  * **NOTE**: You can setup a global function to capture ALL the links clicked across all the TextHTML controls, by setting up:

> TextHTML.mainOnLinkPressed=your\_function;

> were... your\_function:function(String)

**function triggered by a mouseOver a link (in the current TextHTML control)**
  * onLinkEntered:function(String)

  * **NOTE**: You can setup a global function to capture ALL the mouseOver links across all the TextHTML controls, by setting up:

> TextHTML.mainOnLinkEntered=your\_function;

> were... your\_function:function(String)

**function triggered by a mouseExit a link (in the current TextHTML control)**
  * onLinkExited:function(String)

  * **NOTE**: You can setup a global function to capture ALL the mouseExit links across all the TextHTML controls, by setting up:

> TextHTML.mainOnLinkExited=your\_function;

> were... your\_function:function(String)