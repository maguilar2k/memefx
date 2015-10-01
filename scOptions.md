# Options #

**Window horizontal position**
> x: 0.0 (default)

**Window vertical position**
> y: 0.0 (default)

**Window width**
> width: 500.0 (default)

**Window height**
> height: 500.0 (default)

**Filename to store persistent attributes of the stage (in the local filesystem or using the Java Web Start persistence service), every app requires a different filename. Java Web Start apps require a filename only if you have more than one app in the same URL path**
> persistFile: "persistStage.pos" (default)

**Persist window size and position through sessions**
> persist: Boolean

**Persist window position**
> persistPosition: Boolean

**Persist window size**
> persistSize: Boolean

**Initial location of the application ( [check positioning options](scPositioning.md) )**
> initialPosition: `ControlStage.CENTER`

> Available options: `ControlStage.TOP, ControlStage.BOTTOM, ControlStage.LEFT, ControlStage.RIGHT, ControlStage.CENTER`

**Check minimun window width?**
> checkMinWidth: false (default)

**Minimum width**
> minWidth: 200.0 (default)

**Check maximum window width?**
> checkMaxWidth: false (default)

**Maximum width**
> maxWidth: 500.0 (default)

**Check minimun window height?**
> checkMinHeight: false (default)

**Minimum height**
> minHeight: 200.0 (default)

**Check maximum window height?**
> checkMaxHeight: false (default)

**Maximum height**
> maxHeight: 500.0 (default)

**Enforce minimum width?**
> enforceMinWidth: false (default)

**Enforce minimum height?**
> enforceMinHeight: false (default)

**Enforce top edge?**
> limitTop: false (default)

**Enforce bottom edge?**
> limitBottom: false (default)

**Enforce left edge?**
> limitLeft: false (default)

**Enforce right edge?**
> limitRight: false (default)

**Enforce all screen edges?**
> limitBorders: Boolean

**Distance to stick to the screen edges**
> stickyDistance: 40 (default)

**Sticky top edge?**
> stickyTop: false (default)

**Sticky bottom edge?**
> stickyBottom: false (default)

**Sticky left edge?**
> stickyLeft: false (default)

**Sticky right edge?**
> stickyRight: false (default)

**Stick to all the screen edges?**
> stickyBorders: Boolean

**Anchor to the top edge?**
> anchorTop: false (default)

**Anchor to the bottom edge?**
> anchorBottom: false (default)

**Anchor to the left edge?**
> anchorLeft: false (default)

**Anchor to the right edge?**
> anchorRight: false (default)

**Anchor to the center of the screen?**
> anchorCenter: false (default)

**Set maximum screen width to the window, initially. Only the first time, if size persist from session to session.**
> initialMaxWidth: Boolean

**Set maximum screen height to the window, initially.  Only the first time, if size persist from session to session.**
> initialMaxHeight: Boolean

**Enable/disable all the checkings**
> enabled: true (default)

**Locks current width**
> lockWidth: Boolean

**Locks current height**
> lockHeight: Boolean

**Time to check for "stickyness"**
> timeToCheckStickyness: 0.5s (default)

**Time to check place and size**
> timeToCheckPosSize: 0.15s (default)

**Time to check edge anchor**
> timeToCheckAnchoredEdges: 0.3s (default)

**Time to call functions (onResize, onMove)**
> timeToCallFunctions: 0.15s (default)

**Animation Speed (time to relocate window)**
> animationSpeed: 1s (default)