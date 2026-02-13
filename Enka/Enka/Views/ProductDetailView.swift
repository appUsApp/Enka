import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: SeafoodStoreViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            Group {
                if let product = viewModel.selectedProduct {
                    VStack(alignment: .leading, spacing: 14) {
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

                            LinearGradient(
                                colors: [.black.opacity(0.62), .black.opacity(0.14), .clear],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.name)
                                    .font(.system(size: 36, weight: .semibold, design: .serif))
                                    .foregroundStyle(.white)
                                Text("\(product.subtitle) ・ \(product.description)")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundStyle(.white.opacity(0.92))
                                Text("¥\(product.price.formattedWithComma)")
                                    .font(.system(size: 20, weight: .medium, design: .serif))
                                    .foregroundStyle(.white.opacity(0.98))
                            }
                            .padding(16)
                        }

                        CrystalCard {
                            HStack {
                                Text("サイズ選択")
                                Spacer()
                                Text(product.unit)
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                            }
                            .font(.system(size: 19, weight: .medium, design: .serif))
                        }

                        CrystalCard {
                            HStack {
                                Text("数量")
                                    .font(.system(size: 19, weight: .medium, design: .serif))
                                Spacer()
                                StoreQuantityCounter(
                                    quantity: viewModel.quantity,
                                    onDecrease: viewModel.decreaseQuantity,
                                    onIncrease: viewModel.increaseQuantity
                                )
                            }
                        }
                    }
                } else {
                    CrystalCard {
                        Text("商品が選択されていません")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.top, 8)
        }
        .safeAreaInset(edge: .top) {
            StoreBackHeader {
                viewModel.backFromDetail()
            }
            .padding(.top, 6)
            .padding(.bottom, 4)
            .background {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(0.45)
            }
        }
        .safeAreaInset(edge: .bottom) {
            StorePrimaryButton(title: "カートに追加") {
                viewModel.addToCart()
            }
            .disabled(viewModel.selectedProduct == nil)
            .opacity(viewModel.selectedProduct == nil ? 0.55 : 1.0)
            .padding(.top, 6)
            .padding(.bottom, 4)
            .background {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(0.45)
            }
        }
    }
}
