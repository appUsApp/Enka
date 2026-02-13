import SwiftUI

struct OrderConfirmedView: View {
    @ObservedObject var viewModel: SeafoodStoreViewModel

    var body: some View {
        VStack(spacing: 16) {
            StoreBackHeader {
                viewModel.backFromConfirmed()
            }

            Spacer(minLength: 6)

            ZStack {
                Circle()
                    .stroke(.white.opacity(0.65), lineWidth: 6)
                    .frame(width: 130, height: 130)
                Image(systemName: "checkmark")
                    .font(.system(size: 56, weight: .semibold))
                    .foregroundStyle(Color(red: 0.52, green: 0.57, blue: 0.64))
            }

            Text("注文が確定しました")
                .font(.system(size: 42, weight: .semibold, design: .serif))
                .foregroundStyle(StoreTheme.textPrimary)
            Text("ご購入ありがとうございます")
                .font(.system(size: 22, weight: .medium, design: .serif))
                .foregroundStyle(.secondary)

            StoreSoftDivider()

            VStack(alignment: .leading, spacing: 14) {
                Text("注文番号 #672345")
                    .font(.system(size: 20, weight: .medium, design: .serif))
                    .foregroundStyle(StoreTheme.textPrimary)

                CrystalCard {
                    VStack(spacing: 8) {
                        ForEach(viewModel.cartLines) { line in
                            StoreSummaryRow(
                                title: "\(line.product.name) \(line.product.subtitle) x \(line.quantity)",
                                value: line.lineTotal,
                                emphasized: false
                            )
                        }
                        Divider()
                        StoreSummaryRow(title: "合計", value: viewModel.total, emphasized: true)
                    }
                }
            }

            Spacer()

            StorePrimaryButton(title: "注文詳細を見る") {}
        }
        .padding(.top, 8)
    }
}
