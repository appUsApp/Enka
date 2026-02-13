import SwiftUI

enum StoreTheme {
    static let surfaceTintTop = Color(red: 0.98, green: 0.99, blue: 1.0)
    static let surfaceTintBottom = Color(red: 0.78, green: 0.82, blue: 0.88)
    static let textPrimary = Color(red: 0.20, green: 0.24, blue: 0.32)
    static let priceText = Color(red: 0.30, green: 0.35, blue: 0.43)
    static let productImageAspectRatio: CGFloat = 4.0 / 5.0
}

struct StoreBackgroundView: View {
    var body: some View {
        GeometryReader { proxy in
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
                .overlay {
                    LinearGradient(
                        colors: [.white.opacity(0.24), .white.opacity(0.12), .white.opacity(0.20)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .overlay {
                    LinearGradient(
                        colors: [.white.opacity(0.16), .clear, .white.opacity(0.10)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .blendMode(.screen)
                }
        }
        .ignoresSafeArea()
    }
}

struct CrystalCard<Content: View>: View {
    let cornerRadius: CGFloat
    let shadow: CGFloat
    @ViewBuilder let content: () -> Content

    init(cornerRadius: CGFloat = 16, shadow: CGFloat = 14, @ViewBuilder content: @escaping () -> Content) {
        self.cornerRadius = cornerRadius
        self.shadow = shadow
        self.content = content
    }

    var body: some View {
        content()
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.white.opacity(0.30))
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(0.30),
                                        .white.opacity(0.05),
                                        Color(red: 0.84, green: 0.88, blue: 0.94).opacity(0.20)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .inset(by: 0.5)
                            .stroke(
                                LinearGradient(
                                    colors: [.white.opacity(0.95), .white.opacity(0.35), .white.opacity(0.72)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.2
                            )
                    }
                    .overlay(alignment: .top) {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .trim(from: 0, to: 0.46)
                            .stroke(.white.opacity(0.55), lineWidth: 1.0)
                            .blur(radius: 0.4)
                            .padding(1.5)
                    }
                    .shadow(color: .black.opacity(0.10), radius: shadow, y: 6)
            }
    }
}

struct CrystalCapsule<Content: View>: View {
    let shadow: CGFloat
    @ViewBuilder let content: () -> Content

    init(shadow: CGFloat = 8, @ViewBuilder content: @escaping () -> Content) {
        self.shadow = shadow
        self.content = content
    }

    var body: some View {
        content()
            .padding(.horizontal, 14)
            .padding(.vertical, 11)
            .background {
                Capsule(style: .continuous)
                    .fill(.white.opacity(0.30))
                    .background(Capsule(style: .continuous).fill(.ultraThinMaterial))
                    .overlay {
                        Capsule(style: .continuous)
                            .stroke(.white.opacity(0.7), lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.08), radius: shadow, y: 4)
            }
    }
}

struct StoreSearchBar: View {
    let placeholder: String

    var body: some View {
        CrystalCapsule {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                Text(placeholder)
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "mic.fill")
                    .foregroundStyle(.secondary)
            }
            .font(.system(size: 16))
        }
    }
}

struct StoreHeroImage: View {
    let imageName: String
    let height: CGFloat

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                LinearGradient(
                    colors: [.white.opacity(0.20), .clear, .white.opacity(0.12)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.white.opacity(0.50), lineWidth: 1.0)
            }
            .shadow(color: .black.opacity(0.12), radius: 12, y: 7)
    }
}

struct StoreSectionHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 33, weight: .semibold, design: .serif))
                .foregroundStyle(StoreTheme.textPrimary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
    }
}

struct StoreCategoryChip: View {
    let category: SeafoodCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(category.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(isSelected ? .white.opacity(0.95) : .white.opacity(0.45), lineWidth: isSelected ? 2 : 1)
                    }
                Text(category.rawValue)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                    .foregroundStyle(isSelected ? StoreTheme.textPrimary : .secondary)
            }
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

struct StoreProductCard: View {
    let product: Product
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                Color.clear
                    .frame(maxWidth: .infinity)
                    .aspectRatio(StoreTheme.productImageAspectRatio, contentMode: .fit)
                    .overlay {
                        Image(product.imageName)
                            .resizable()
                            .scaledToFill()
                    }
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                LinearGradient(
                    colors: [.black.opacity(0.58), .black.opacity(0.16), .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(product.name)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .foregroundStyle(.white)
                        Text(product.subtitle)
                            .font(.system(size: 13, weight: .medium, design: .serif))
                            .foregroundStyle(.white.opacity(0.92))
                    }

                    Spacer(minLength: 8)

                    Text("¥\(product.price.formattedWithComma)")
                        .font(.system(size: 15, weight: .medium, design: .serif))
                        .foregroundStyle(.white.opacity(0.98))
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule(style: .continuous)
                                .fill(.white.opacity(0.22))
                                .overlay(
                                    Capsule(style: .continuous)
                                        .stroke(.white.opacity(0.45), lineWidth: 1)
                                )
                        )
                }
                .padding(12)
            }
            .background {
                CrystalCard(cornerRadius: 20, shadow: 10) {
                    Color.clear
                }
            }
        }
        .buttonStyle(.plain)
    }
}

struct StoreSoftDivider: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [.white.opacity(0.10), .white.opacity(0.72), .white.opacity(0.10)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 1)
            .overlay(Rectangle().fill(Color(red: 0.73, green: 0.78, blue: 0.85).opacity(0.18)).offset(y: 1))
    }
}

struct StorePrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 32, weight: .semibold, design: .serif))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.54, green: 0.60, blue: 0.69).opacity(0.92),
                                    Color(red: 0.34, green: 0.39, blue: 0.47).opacity(0.94)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.white.opacity(0.32), .clear, .white.opacity(0.12)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(.white.opacity(0.46), lineWidth: 1.0)
                        }
                        .shadow(color: Color(red: 0.23, green: 0.28, blue: 0.36).opacity(0.28), radius: 8, y: 4)
                }
        }
        .buttonStyle(.plain)
    }
}

struct StoreBackHeader: View {
    let action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 26, weight: .medium))
                    .foregroundStyle(Color(red: 0.41, green: 0.46, blue: 0.55))
            }
            .buttonStyle(.plain)

            Spacer()
        }
    }
}

struct StoreQuantityCounter: View {
    let quantity: Int
    let onDecrease: () -> Void
    let onIncrease: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            buttonSquare(symbol: "minus", action: onDecrease)

            Text("\(quantity)")
                .font(.system(size: 25, weight: .bold, design: .serif))
                .frame(minWidth: 24)

            buttonSquare(symbol: "plus", action: onIncrease)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background {
            CrystalCard(cornerRadius: 10, shadow: 4) {
                Color.clear
            }
        }
    }

    private func buttonSquare(symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 14, weight: .bold))
                .frame(width: 28, height: 28)
                .background {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.white.opacity(0.45))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(.white.opacity(0.65), lineWidth: 1)
                        }
                }
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color(red: 0.36, green: 0.41, blue: 0.49))
    }
}

struct StoreCartLineRow: View {
    let line: CartLine

    var body: some View {
        HStack(spacing: 10) {
            Image(line.product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            VStack(alignment: .leading, spacing: 5) {
                Text(line.product.name)
                    .font(.system(size: 23, weight: .medium, design: .serif))
                    .foregroundStyle(StoreTheme.textPrimary)
                Text(line.product.subtitle)
                    .font(.system(size: 18, weight: .medium, design: .serif))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Text("¥\(line.product.price.formattedWithComma)")
                    .font(.system(size: 19, weight: .regular, design: .serif))
                    .foregroundStyle(StoreTheme.priceText)
                Text("x \(line.quantity)")
                    .font(.system(size: 17, weight: .medium, design: .serif))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct StoreSummaryRow: View {
    let title: String
    let value: Int
    let emphasized: Bool

    var body: some View {
        HStack {
            Text("\(title):")
                .font(.system(size: emphasized ? 22 : 18, weight: .medium, design: .serif))
                .foregroundStyle(StoreTheme.textPrimary)
            Spacer()
            Text("¥\(value.formattedWithComma)")
                .font(.system(size: emphasized ? 25 : 21, weight: emphasized ? .medium : .regular, design: .serif))
                .foregroundStyle(emphasized ? StoreTheme.textPrimary : StoreTheme.priceText)
        }
    }
}

struct StoreBottomNavBar: View {
    let appScreen: AppScreen
    let onSelect: (AppScreen) -> Void

    var body: some View {
        HStack(spacing: 18) {
            navItem(title: "Home", icon: "house.fill", isActive: appScreen == .home || appScreen == .categoryProducts || appScreen == .productDetail) {
                onSelect(.home)
            }
            navItem(title: "Campaign", icon: "megaphone.fill", isActive: appScreen == .campaign) {
                onSelect(.campaign)
            }
            navItem(title: "Cart", icon: "cart.fill", isActive: appScreen == .cart || appScreen == .orderConfirmed) {
                onSelect(.cart)
            }
            navItem(title: "Account", icon: "person.fill", isActive: appScreen == .account) {
                onSelect(.account)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background {
            Capsule(style: .continuous)
                .fill(.white.opacity(0.35))
                .background(Capsule(style: .continuous).fill(.ultraThinMaterial))
                .overlay {
                    Capsule(style: .continuous)
                        .stroke(.white.opacity(0.7), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
        }
    }

    private func navItem(title: String, icon: String, isActive: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                Text(title)
                    .font(.system(size: 11, weight: .medium))
            }
            .foregroundStyle(isActive ? Color(red: 0.30, green: 0.36, blue: 0.45) : .secondary)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}
