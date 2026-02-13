import SwiftUI

struct CategoryProductsView: View {
    @ObservedObject var viewModel: SeafoodStoreViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                StoreBackHeader {
                    viewModel.backFromCategoryProducts()
                }

                Text(viewModel.selectedCategory.rawValue)
                    .font(.system(size: 43, weight: .semibold, design: .serif))
                    .foregroundStyle(StoreTheme.textPrimary)
                Text("カテゴリ商品一覧")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.secondary)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(viewModel.filteredProducts) { product in
                        StoreProductCard(product: product) {
                            viewModel.openDetail(for: product)
                        }
                    }
                }
            }
            .padding(.top, 8)
        }
    }
}
