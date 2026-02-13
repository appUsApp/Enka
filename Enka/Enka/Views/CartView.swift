import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: SeafoodStoreViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("カート")
                .font(.system(size: 44, weight: .semibold, design: .serif))
                .foregroundStyle(StoreTheme.textPrimary)

            if viewModel.cartLines.isEmpty {
                CrystalCard {
                    Text("カートは空です。カテゴリーから商品を追加してください。")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                Spacer(minLength: 10)
            } else {
                CrystalCard {
                    VStack(spacing: 12) {
                        ForEach(viewModel.cartLines) { line in
                            StoreCartLineRow(line: line)
                        }
                    }
                }

                StoreSoftDivider()

                VStack(spacing: 10) {
                    StoreSummaryRow(title: "小計", value: viewModel.subtotal, emphasized: false)
                    StoreSummaryRow(title: "送料", value: viewModel.shippingFee, emphasized: false)
                    StoreSummaryRow(title: "合計", value: viewModel.total, emphasized: true)
                }

                Spacer(minLength: 10)

                StorePrimaryButton(title: "購入手続きへ") {
                    viewModel.checkout()
                }
            }
        }
        .padding(.top, 8)
    }
}
