# ``FlipView``

FlipView is a SwiftUI library with a ``FlipView`` component that works on all major Apple platforms.


## Overview

![Library logotype](Logo.png)

FlipView is a SwiftUI library with a ``FlipView`` component that works on all major Apple platforms.



## Installation

FlipView can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/FlipView.git
```


## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting started

With `FlipView`, you just have to provide a front and back view: 

```swift
import FlipView

struct MyView: View {

    @State private var isFlipped = false

    var body: some View {
        FlipView(
            isFlipped: $isFlipped,
            flipDuration: 1.0,
            tapDirection: .right,
            swipeDirections: [.left, .right, .up, .down],
            front: { Color.green.overlay(Text("Front")) },
            back: { Color.red.overlay(Text("Back")) }
        )
        .withListRenderingBugFix()  // Use this when in a List 
    }
}
```

You can flip the view programatically by just toggling `isFlipped` with code.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/FlipView).



## License

FlipView is available under the MIT license.



## Topics

### Essentials

- ``FlipView/FlipView``
- ``FlipDirection``
- ``FlipGestureViewModifier``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi
