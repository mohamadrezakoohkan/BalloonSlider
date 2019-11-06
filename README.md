
# BalloonSlider
`UISlier` with Animated Balloon representing slider value.

![BalloonSlider](https://github.com/mohamadrezakoohkan/BalloonSlider/blob/master/screenCapture.gif)

## Installation

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Dequer` by adding the dequer package description to your `Package.swift` file:

```swift
// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/mohamadrezakoohkan/BalloonSlider.git", from: "1.0.0"),
    ]
)
```
Then run `swift build` in Terminal to build `Dequer`.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can use source code manually. get latest relase from [Releases](https://github.com/mohamadrezakoohkan/BalloonSlider/releases).



## Usage

### Example project

Clone the project and use example project.

#

Example of how to implement BalloonSlider in your project.

If you added project by **Swift Package Manager** then you need to import BalloonSlider.

```swift

import UIKit

class ViewController: UIViewController {

  lazy var balloonSliderView: BalloonSliderView = {
      let frame = BalloonSliderView.commonFrame(xPadding: 40, on: self.view))
      BalloonSliderView(frame: frame)
  }()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.view.addSubview(self.balloonSliderView)
  }
  
}
```

### Contact

Follow and contact me on [Instagram](https://www.instagram.com/mohamadreza.codes/),  [Github](https://github.com/mohamadrezakoohkan), [LinkedIn](https://www.linkedin.com/in/mohammad-reza-koohkan-558306160/) and [stack overflow](https://stackoverflow.com/users/9706268/mohamad-reza-koohkan?tab=profile). If you find an issue [open a ticket](https://github.com/mohamadrezakoohkan/Dequerissues/new). You can send me email at mohamad_koohkan@icloud.com .

### License
BalloonSlider is released under the [MIT license](https://github.com/mohamadrezakoohkan/BalloonSlider/blob/master/LICENSE.md).
