import Foundation
import Combine

final class SeafoodStoreViewModel: ObservableObject {
    @Published var appScreen: AppScreen = .home
    @Published var quantity: Int = 1
    @Published var selectedCategory: SeafoodCategory = .mukiKaki
    @Published private(set) var selectedProduct: Product?
    @Published private(set) var recommendedProducts: [Product] = []
    @Published private var cartQuantities: [UUID: Int] = [:]
    @Published private(set) var homeRestoreProductID: UUID?

    private var lastPrimaryTab: AppScreen = .home

    let products: [Product] = [
        Product(id: UUID(), category: .mukiKaki, name: "ムキガキ", subtitle: "200g", description: "加熱用・小粒", unit: "200g", price: 1_680, imageName: "oyster01"),
        Product(id: UUID(), category: .mukiKaki, name: "ムキガキ", subtitle: "400g", description: "加熱用・標準", unit: "400g", price: 2_980, imageName: "oyster01"),
        Product(id: UUID(), category: .mukiKaki, name: "ムキガキ", subtitle: "800g", description: "たっぷり業務用", unit: "800g", price: 5_600, imageName: "oyster01"),

        Product(id: UUID(), category: .crab, name: "かに脚", subtitle: "300g", description: "ボイル済み", unit: "300g", price: 3_800, imageName: "clab"),
        Product(id: UUID(), category: .crab, name: "かに脚", subtitle: "500g", description: "旨み濃厚", unit: "500g", price: 5_980, imageName: "clab"),
        Product(id: UUID(), category: .crab, name: "かに脚", subtitle: "1kg", description: "家族向け大容量", unit: "1kg", price: 11_200, imageName: "clab"),

        Product(id: UUID(), category: .shellOyster, name: "殻牡蠣", subtitle: "500g", description: "殻付き・生食可", unit: "500g", price: 2_980, imageName: "oyster02"),
        Product(id: UUID(), category: .shellOyster, name: "殻牡蠣", subtitle: "1kg", description: "BBQ向け", unit: "1kg", price: 5_480, imageName: "oyster02"),
        Product(id: UUID(), category: .shellOyster, name: "殻牡蠣", subtitle: "2kg", description: "大容量セット", unit: "2kg", price: 10_200, imageName: "oyster02"),

        Product(id: UUID(), category: .asari, name: "アサリ", subtitle: "300g", description: "砂抜き済み", unit: "300g", price: 1_200, imageName: "clam"),
        Product(id: UUID(), category: .asari, name: "アサリ", subtitle: "600g", description: "味噌汁に最適", unit: "600g", price: 2_200, imageName: "clam"),
        Product(id: UUID(), category: .asari, name: "アサリ", subtitle: "1kg", description: "たっぷりお得", unit: "1kg", price: 3_500, imageName: "clam"),

        Product(id: UUID(), category: .shrimp, name: "エビ", subtitle: "250g", description: "プリプリ食感", unit: "250g", price: 1_980, imageName: "shrimp"),
        Product(id: UUID(), category: .shrimp, name: "エビ", subtitle: "500g", description: "人気サイズ", unit: "500g", price: 3_680, imageName: "shrimp"),
        Product(id: UUID(), category: .shrimp, name: "エビ", subtitle: "1kg", description: "特大パック", unit: "1kg", price: 6_980, imageName: "shrimp")
    ]

    let campaignBanners: [CampaignBanner] = [
        CampaignBanner(title: "冬の海鮮フェア", subtitle: "対象商品が最大20%OFF", tag: "期間限定"),
        CampaignBanner(title: "週末限定タイムセール", subtitle: "本マグロ・牡蠣セット特価", tag: "今だけ")
    ]

    let coupons: [CouponItem] = [
        CouponItem(code: "SEAFOOD500", description: "5,000円以上の購入で500円OFF", expiresAt: "2026/03/31"),
        CouponItem(code: "FIRST10", description: "初回注文 10%OFF", expiresAt: "2026/04/15")
    ]

    let accountMenus: [AccountMenuItem] = [
        AccountMenuItem(title: "プロフィール", subtitle: "名前・連絡先を更新", icon: "person.crop.circle"),
        AccountMenuItem(title: "配送先", subtitle: "住所・受け取り設定", icon: "truck.box"),
        AccountMenuItem(title: "支払い方法", subtitle: "カード・請求情報", icon: "creditcard")
    ]

    let searchPlaceholder = "海産物を検索"

    init() {
        selectedProduct = filteredProducts.first
        refreshRecommendedProducts()
    }

    var filteredProducts: [Product] {
        products.filter { $0.category == selectedCategory }
    }

    var cartLines: [CartLine] {
        products.compactMap { product in
            guard let count = cartQuantities[product.id], count > 0 else { return nil }
            return CartLine(id: product.id, product: product, quantity: count)
        }
    }

    var subtotal: Int {
        cartLines.reduce(0) { $0 + $1.lineTotal }
    }

    var shippingFee: Int {
        cartLines.isEmpty ? 0 : 800
    }

    var total: Int {
        subtotal + shippingFee
    }

    func refreshRecommendedProducts() {
        recommendedProducts = Array(products.shuffled().prefix(8))
    }

    func openCategoryProducts(for category: SeafoodCategory) {
        selectedCategory = category
        if selectedProduct?.category != category {
            selectedProduct = filteredProducts.first
        }
        appScreen = .categoryProducts
    }

    func backFromCategoryProducts() {
        appScreen = .home
    }

    func openDetail(for product: Product) {
        selectedProduct = product
        quantity = 1
        appScreen = .productDetail
    }

    func openDetailFromHome(for product: Product) {
        homeRestoreProductID = product.id
        lastPrimaryTab = .home
        openDetail(for: product)
    }

    func consumeHomeRestoreProductID() -> UUID? {
        let id = homeRestoreProductID
        homeRestoreProductID = nil
        return id
    }

    func backFromDetail() {
        appScreen = lastPrimaryTab
    }

    func addToCart() {
        guard let product = selectedProduct else { return }
        cartQuantities[product.id, default: 0] += quantity
        appScreen = .cart
        lastPrimaryTab = .cart
    }

    func checkout() {
        guard !cartLines.isEmpty else { return }
        appScreen = .orderConfirmed
    }

    func backFromConfirmed() {
        appScreen = .cart
        lastPrimaryTab = .cart
    }

    func moveTo(_ destination: AppScreen) {
        appScreen = destination
        if destination.isPrimaryTab {
            lastPrimaryTab = destination
        }
    }

    func increaseQuantity() {
        quantity += 1
    }

    func decreaseQuantity() {
        quantity = max(1, quantity - 1)
    }
}
