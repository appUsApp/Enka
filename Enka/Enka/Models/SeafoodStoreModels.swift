import Foundation

enum AppScreen {
    case home
    case campaign
    case cart
    case account
    case categoryProducts
    case productDetail
    case orderConfirmed
}

extension AppScreen {
    var isPrimaryTab: Bool {
        switch self {
        case .home, .campaign, .cart, .account:
            return true
        case .categoryProducts, .productDetail, .orderConfirmed:
            return false
        }
    }
}

enum SeafoodCategory: String, CaseIterable, Identifiable {
    case mukiKaki = "ムキガキ"
    case crab = "かに"
    case shellOyster = "殻牡蠣"
    case asari = "アサリ"
    case shrimp = "エビ"

    var id: String { rawValue }

    var imageName: String {
        switch self {
        case .mukiKaki:
            return "oyster01"
        case .crab:
            return "clab"
        case .shellOyster:
            return "oyster02"
        case .asari:
            return "clam"
        case .shrimp:
            return "shrimp"
        }
    }
}

struct Product: Identifiable {
    let id: UUID
    let category: SeafoodCategory
    let name: String
    let subtitle: String
    let description: String
    let unit: String
    let price: Int
    let imageName: String
}

struct CartLine: Identifiable {
    let id: UUID
    let product: Product
    let quantity: Int

    var lineTotal: Int {
        product.price * quantity
    }
}

struct CampaignBanner: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let tag: String
}

struct CouponItem: Identifiable {
    let id = UUID()
    let code: String
    let description: String
    let expiresAt: String
}

struct AccountMenuItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
}

extension Int {
    var formattedWithComma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
