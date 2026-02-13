import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "campaign" asset catalog image resource.
    static let campaign = DeveloperToolsSupport.ImageResource(name: "campaign", bundle: resourceBundle)

    /// The "clab" asset catalog image resource.
    static let clab = DeveloperToolsSupport.ImageResource(name: "clab", bundle: resourceBundle)

    /// The "clam" asset catalog image resource.
    static let clam = DeveloperToolsSupport.ImageResource(name: "clam", bundle: resourceBundle)

    /// The "oyster01" asset catalog image resource.
    static let oyster01 = DeveloperToolsSupport.ImageResource(name: "oyster01", bundle: resourceBundle)

    /// The "oyster02" asset catalog image resource.
    static let oyster02 = DeveloperToolsSupport.ImageResource(name: "oyster02", bundle: resourceBundle)

    /// The "shrimp" asset catalog image resource.
    static let shrimp = DeveloperToolsSupport.ImageResource(name: "shrimp", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "campaign" asset catalog image.
    static var campaign: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .campaign)
#else
        .init()
#endif
    }

    /// The "clab" asset catalog image.
    static var clab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clab)
#else
        .init()
#endif
    }

    /// The "clam" asset catalog image.
    static var clam: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clam)
#else
        .init()
#endif
    }

    /// The "oyster01" asset catalog image.
    static var oyster01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .oyster01)
#else
        .init()
#endif
    }

    /// The "oyster02" asset catalog image.
    static var oyster02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .oyster02)
#else
        .init()
#endif
    }

    /// The "shrimp" asset catalog image.
    static var shrimp: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shrimp)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "campaign" asset catalog image.
    static var campaign: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .campaign)
#else
        .init()
#endif
    }

    /// The "clab" asset catalog image.
    static var clab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clab)
#else
        .init()
#endif
    }

    /// The "clam" asset catalog image.
    static var clam: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clam)
#else
        .init()
#endif
    }

    /// The "oyster01" asset catalog image.
    static var oyster01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .oyster01)
#else
        .init()
#endif
    }

    /// The "oyster02" asset catalog image.
    static var oyster02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .oyster02)
#else
        .init()
#endif
    }

    /// The "shrimp" asset catalog image.
    static var shrimp: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shrimp)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

