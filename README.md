<p align="center">
    <img src="Resources/Icon.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/FlipKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.0" />
    <a href="https://danielsaidi.github.io/FlipKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/FlipKit/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/FlipKit" alt="MIT License" /></a>
    <a href="https://github.com/sponsors/danielsaidi"><img src="https://img.shields.io/badge/sponsor-GitHub-red.svg" alt="Sponsor my work" /></a>
</p>


# FlipKit

FlipKit is a SwiftUI library with a `FlipView` component that works on all major Apple platforms.



## Installation

FlipKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/FlipKit.git
```


## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting Started

With FlipKit's `FlipView`, you just have to provide a front and back view: 

```swift
import FlipKit

struct MyView: View {

    @State private var isFlipped = false

    var body: some View {
        FlipView(
            isFlipped: $isFlipped,
            flipDuration: 1.0,
            tapDirection: .right,
            flipDirections: [.left, .right, .up, .down],
            front: { Card(color: .green) },
            back: { Card(color: .red) }
        )
        .withListRenderingBugFix()  // Use this when in a List 
    }
}

struct Card: View {

    let color: Color

    var body: some View {
        color.cornerRadius(10)
    }
}
```

You can flip the view programatically by just toggling `isFlipped` with code.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has a demo app that lets you explore the library and integrate with a few APIs.



## Contact

Feel free to reach out if you have questions, or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

FlipKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Mastodon]: https://mastodon.social/@danielsaidi
[Twitter]: https://twitter.com/danielsaidi

[Documentation]: https://danielsaidi.github.io/FlipKit
[Getting-Started]: https://danielsaidi.github.io/FlipKit/documentation/flipkit/getting-started
[License]: https://github.com/danielsaidi/FlipKit/blob/master/LICENSE
