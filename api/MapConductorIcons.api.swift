import CoreGraphics
import Foundation
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
public enum CommonMapIcons {
  public static let hospital: MapConductorIcons.MapIconGlyph
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
public enum MapIconPathCommand : Swift.Hashable, Swift.Sendable {
  case moveTo(CoreFoundation.CGPoint)
  case lineTo(CoreFoundation.CGPoint)
  case curveTo(end: CoreFoundation.CGPoint, control1: CoreFoundation.CGPoint, control2: CoreFoundation.CGPoint)
  case close
  public static func == (a: MapConductorIcons.MapIconPathCommand, b: MapConductorIcons.MapIconPathCommand) -> Swift.Bool
  public func hash(into hasher: inout Swift.Hasher)
  public var hashValue: Swift.Int {
    get
  }
}
public struct MapIconGlyph : Swift.Hashable, Swift.Sendable {
  public let id: Swift.String
  public let commands: [MapConductorIcons.MapIconPathCommand]
  public let viewBoxSize: CoreFoundation.CGFloat
  public init(id: Swift.String, commands: [MapConductorIcons.MapIconPathCommand], viewBoxSize: CoreFoundation.CGFloat = 24.0)
  public static func == (a: MapConductorIcons.MapIconGlyph, b: MapConductorIcons.MapIconGlyph) -> Swift.Bool
  public func hash(into hasher: inout Swift.Hasher)
  public var hashValue: Swift.Int {
    get
  }
}
final public class PinGlyphIcon : MapConductorCore.MarkerIconProtocol {
  public static let defaultIconSize: CoreFoundation.CGFloat
  public static let defaultStrokeWidth: CoreFoundation.CGFloat
  public static let defaultAnchor: CoreFoundation.CGPoint
  public static let defaultInfoAnchor: CoreFoundation.CGPoint
  final public let glyph: MapConductorIcons.MapIconGlyph
  final public let scale: CoreFoundation.CGFloat
  final public let anchor: CoreFoundation.CGPoint
  final public let iconSize: CoreFoundation.CGFloat
  final public let infoAnchor: CoreFoundation.CGPoint
  final public let debug: Swift.Bool
  public init(glyph: MapConductorIcons.MapIconGlyph, fillColor: UIKit.UIColor = .red, glyphColor: UIKit.UIColor = .white, strokeColor: UIKit.UIColor = .white, strokeWidth: CoreFoundation.CGFloat = defaultStrokeWidth, scale: CoreFoundation.CGFloat = 1.0, infoAnchor: CoreFoundation.CGPoint = defaultInfoAnchor, iconSize: CoreFoundation.CGFloat = defaultIconSize, debug: Swift.Bool = false)
  final public func toBitmapIcon() -> MapConductorCore.BitmapIcon
  final public func hashCode() -> Swift.Int
  final public func copy(glyph: MapConductorIcons.MapIconGlyph? = nil, fillColor: UIKit.UIColor? = nil, glyphColor: UIKit.UIColor? = nil, strokeColor: UIKit.UIColor? = nil, strokeWidth: CoreFoundation.CGFloat? = nil, scale: CoreFoundation.CGFloat? = nil, infoAnchor: CoreFoundation.CGPoint? = nil, iconSize: CoreFoundation.CGFloat? = nil, debug: Swift.Bool? = nil) -> MapConductorIcons.PinGlyphIcon
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
