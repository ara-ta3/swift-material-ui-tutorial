import UIKit

import MaterialComponents

class ApplicationScheme: NSObject {

  private static var singleton = ApplicationScheme()

  static var shared: ApplicationScheme {
    return singleton
  }

  override init() {
    self.buttonScheme.colorScheme = self.colorScheme
    self.buttonScheme.typographyScheme = self.typographyScheme
    super.init()
  }

  public let buttonScheme = MDCContainerScheme()

  public let colorScheme: MDCSemanticColorScheme = {
    let scheme = MDCSemanticColorScheme(defaults: .material201804)
    scheme.primaryColor =
            UIColor(red: 36.0/255.0, green: 42.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    scheme.primaryColorVariant =
            UIColor(red: 101.0/255.0, green: 99.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    scheme.onPrimaryColor =
            UIColor(red: 255.0/255.0, green: 251.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    scheme.secondaryColor =
            UIColor(red: 101.0/255.0, green: 180.0/255.0, blue: 81.0/255.0, alpha: 1.0)
    scheme.onSecondaryColor =
            UIColor(red: 48.0/255.0, green: 96.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    // FIXME
    scheme.surfaceColor =
            UIColor(red: 255.0/255.0, green: 251.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    // FIXME
    scheme.onSurfaceColor =
            UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    // FIXME
    scheme.backgroundColor =
            UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    // FIXME #363F4D
    scheme.onBackgroundColor =
            UIColor(red: 54.0/255.0, green: 63.0/255.0, blue: 77.0/255.0, alpha: 1.0)
    scheme.errorColor =
            UIColor(red: 224.0/255.0, green: 84.0/255.0, blue: 53.0/255.0, alpha: 1.0)
    return scheme
  }()

  public let typographyScheme: MDCTypographyScheme = {
    let scheme = MDCTypographyScheme()
    let fontName = "NotoSansChakma-Regular"
    scheme.headline5 = UIFont(name: fontName, size: 24)!
    scheme.headline6 = UIFont(name: fontName, size: 20)!
    scheme.subtitle1 = UIFont(name: fontName, size: 16)!
    scheme.button = UIFont(name: fontName, size: 14)!
    return scheme
  }()
}
