import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: SeafoodStoreViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    StoreSearchBar(placeholder: viewModel.searchPlaceholder)

                    ZStack(alignment: .bottomLeading) {
                        StoreHeroImage(imageName: "campaign", height: 205)

                        LinearGradient(
                            colors: [.black.opacity(0.38), .clear],
                            startPoint: .bottom,
                            endPoint: .center
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("極上の海鮮")
                                .font(.system(size: 38, weight: .semibold, design: .serif))
                                .foregroundStyle(.white)
                            Text("新鮮で上質な味わい")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundStyle(.white.opacity(0.9))
                        }
                        .padding(16)
                    }

                    StoreSectionHeader(title: "カテゴリー")

                    HStack(spacing: 12) {
                        ForEach(SeafoodCategory.allCases) { category in
                            StoreCategoryChip(category: category, isSelected: viewModel.selectedCategory == category) {
                                viewModel.openCategoryProducts(for: category)
                            }
                        }
                    }

                    StoreSectionHeader(title: "おすすめ")

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(viewModel.recommendedProducts) { product in
                            StoreProductCard(product: product) {
                                viewModel.openDetailFromHome(for: product)
                            }
                            .id(product.id)
                        }
                    }
                }
                .padding(.top, 8)
            }
            .onAppear {
                restoreScrollPositionIfNeeded(with: proxy)
            }
            .onChange(of: viewModel.appScreen) { _, screen in
                guard screen == .home else { return }
                restoreScrollPositionIfNeeded(with: proxy)
            }
        }
    }

    private func restoreScrollPositionIfNeeded(with proxy: ScrollViewProxy) {
        guard let targetID = viewModel.consumeHomeRestoreProductID() else { return }
        DispatchQueue.main.async {
            proxy.scrollTo(targetID, anchor: .top)
        }
    }
}
