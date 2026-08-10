import CoreGraphics
import MapConductorCore
import Swift
import UIKit
import _Concurrency
import _StringProcessing
import _SwiftConcurrencyShims
final public class CircleIcon : MapConductorCore.MarkerIconProtocol {
  public static let defaultIconSize: CoreFoundation.CGFloat
  public static let defaultStrokeWidth: CoreFoundation.CGFloat
  public static let defaultFillColor: UIKit.UIColor
  public static let defaultStrokeColor: UIKit.UIColor
  public static let defaultAnchor: CoreFoundation.CGPoint
  public static let defaultInfoAnchor: CoreFoundation.CGPoint
  final public let iconSize: CoreFoundation.CGFloat
  final public let scale: CoreFoundation.CGFloat
  final public let anchor: CoreFoundation.CGPoint
  final public let infoAnchor: CoreFoundation.CGPoint
  final public let debug: Swift.Bool
  public init(fillColor: UIKit.UIColor = defaultFillColor, strokeColor: UIKit.UIColor = defaultStrokeColor, strokeWidth: CoreFoundation.CGFloat = defaultStrokeWidth, scale: CoreFoundation.CGFloat = 1.0, iconSize: CoreFoundation.CGFloat = defaultIconSize, debug: Swift.Bool = false)
  final public func toBitmapIcon() -> MapConductorCore.BitmapIcon
  final public func hashCode() -> Swift.Int
  final public func copy(fillColor: UIKit.UIColor? = nil, strokeColor: UIKit.UIColor? = nil, strokeWidth: CoreFoundation.CGFloat? = nil, scale: CoreFoundation.CGFloat? = nil, iconSize: CoreFoundation.CGFloat? = nil, debug: Swift.Bool? = nil) -> MapConductorIcons.CircleIcon
  @objc deinit
}
final public class FlagIcon : MapConductorCore.MarkerIconProtocol {
  public static let defaultIconSize: CoreFoundation.CGFloat
  public static let defaultStrokeWidth: CoreFoundation.CGFloat
  public static let defaultFillColor: UIKit.UIColor
  public static let defaultStrokeColor: UIKit.UIColor
  public static let defaultAnchor: CoreFoundation.CGPoint
  public static let defaultInfoAnchor: CoreFoundation.CGPoint
  final public let iconSize: CoreFoundation.CGFloat
  final public let scale: CoreFoundation.CGFloat
  final public let anchor: CoreFoundation.CGPoint
  final public let infoAnchor: CoreFoundation.CGPoint
  final public let debug: Swift.Bool
  public init(fillColor: UIKit.UIColor = defaultFillColor, strokeColor: UIKit.UIColor = defaultStrokeColor, strokeWidth: CoreFoundation.CGFloat = defaultStrokeWidth, scale: CoreFoundation.CGFloat = 1.0, iconSize: CoreFoundation.CGFloat = defaultIconSize, debug: Swift.Bool = false)
  final public func toBitmapIcon() -> MapConductorCore.BitmapIcon
  final public func hashCode() -> Swift.Int
  final public func copy(fillColor: UIKit.UIColor? = nil, strokeColor: UIKit.UIColor? = nil, strokeWidth: CoreFoundation.CGFloat? = nil, scale: CoreFoundation.CGFloat? = nil, iconSize: CoreFoundation.CGFloat? = nil, debug: Swift.Bool? = nil) -> MapConductorIcons.FlagIcon
  @objc deinit
}
final public class RightTailInfoBubbleIcon : MapConductorCore.MarkerIconProtocol {
  public static let defaultIconSize: CoreFoundation.CGFloat
  public static let defaultFillColor: UIKit.UIColor
  public static let defaultLabelTextColor: UIKit.UIColor
  public static let defaultSnippetColor: UIKit.UIColor
  public static let defaultAnchor: CoreFoundation.CGPoint
  public static let defaultInfoAnchor: CoreFoundation.CGPoint
  final public let iconSize: CoreFoundation.CGFloat
  final public let scale: CoreFoundation.CGFloat
  final public let anchor: CoreFoundation.CGPoint
  final public let infoAnchor: CoreFoundation.CGPoint
  final public let debug: Swift.Bool
  public init(image: UIKit.UIImage, label: Swift.String, snippet: Swift.String, fillColor: UIKit.UIColor = defaultFillColor, labelTextColor: UIKit.UIColor = defaultLabelTextColor, scale: CoreFoundation.CGFloat = 1.0, iconSize: CoreFoundation.CGFloat = defaultIconSize, debug: Swift.Bool = false)
  final public func toBitmapIcon() -> MapConductorCore.BitmapIcon
  final public func hashCode() -> Swift.Int
  final public func copy(image: UIKit.UIImage? = nil, label: Swift.String? = nil, snippet: Swift.String? = nil, fillColor: UIKit.UIColor? = nil, labelTextColor: UIKit.UIColor? = nil, scale: CoreFoundation.CGFloat? = nil, iconSize: CoreFoundation.CGFloat? = nil, debug: Swift.Bool? = nil) -> MapConductorIcons.RightTailInfoBubbleIcon
  @objc deinit
}
final public class RoundInfoBubbleIcon : MapConductorCore.MarkerIconProtocol {
  public static let defaultIconSize: CoreFoundation.CGFloat
  public static let defaultFillColor: UIKit.UIColor
  public static let defaultLabelColor: UIKit.UIColor
  public static let defaultAnchor: CoreFoundation.CGPoint
  public static let defaultInfoAnchor: CoreFoundation.CGPoint
  final public let iconSize: CoreFoundation.CGFloat
  final public let scale: CoreFoundation.CGFloat
  final public let anchor: CoreFoundation.CGPoint
  final public let infoAnchor: CoreFoundation.CGPoint
  final public let debug: Swift.Bool
  public init(image: UIKit.UIImage, label: Swift.String, fillColor: UIKit.UIColor = defaultFillColor, scale: CoreFoundation.CGFloat = 1.0, iconSize: CoreFoundation.CGFloat = defaultIconSize, debug: Swift.Bool = false)
  final public func toBitmapIcon() -> MapConductorCore.BitmapIcon
  final public func hashCode() -> Swift.Int
  final public func copy(image: UIKit.UIImage? = nil, label: Swift.String? = nil, fillColor: UIKit.UIColor? = nil, scale: CoreFoundation.CGFloat? = nil, iconSize: CoreFoundation.CGFloat? = nil, debug: Swift.Bool? = nil) -> MapConductorIcons.RoundInfoBubbleIcon
  @objc deinit
}
