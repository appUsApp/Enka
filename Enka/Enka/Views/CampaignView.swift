import SwiftUI

struct CampaignView: View {
    @ObservedObject var viewModel: SeafoodStoreViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                Text("キャンペーン")
                    .font(.system(size: 43, weight: .semibold, design: .serif))
                    .foregroundStyle(StoreTheme.textPrimary)

                ForEach(viewModel.campaignBanners) { banner in
                    CrystalCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(banner.tag)
                                .font(.system(size: 13, weight: .bold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(.white.opacity(0.65))
                                )
                            Text(banner.title)
                                .font(.system(size: 28, weight: .semibold, design: .serif))
                                .foregroundStyle(StoreTheme.textPrimary)
                            Text(banner.subtitle)
                                .font(.system(size: 17, weight: .medium, design: .serif))
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                StoreSectionHeader(title: "クーポン")

                ForEach(viewModel.coupons) { coupon in
                    CrystalCard {
                        HStack(alignment: .top, spacing: 12) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(coupon.code)
                                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                                    .foregroundStyle(StoreTheme.textPrimary)
                                Text(coupon.description)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundStyle(.secondary)
                                Text("有効期限: \(coupon.expiresAt)")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Button("適用") {}
                                .buttonStyle(.plain)
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 7)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(.white.opacity(0.72))
                                )
                                .overlay {
                                    Capsule(style: .continuous)
                                        .stroke(.white.opacity(0.88), lineWidth: 1)
                                }
                                .foregroundStyle(StoreTheme.textPrimary)
                        }
                    }
                }
            }
            .padding(.top, 8)
        }
    }
}
