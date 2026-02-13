import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: SeafoodStoreViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                Text("アカウント")
                    .font(.system(size: 43, weight: .semibold, design: .serif))
                    .foregroundStyle(StoreTheme.textPrimary)

                CrystalCard {
                    HStack(spacing: 14) {
                        Circle()
                            .fill(.white.opacity(0.7))
                            .frame(width: 56, height: 56)
                            .overlay {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(Color(red: 0.42, green: 0.48, blue: 0.56))
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("海鮮 太郎")
                                .font(.system(size: 24, weight: .semibold, design: .serif))
                                .foregroundStyle(StoreTheme.textPrimary)
                            Text("member@enka.app")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                }

                StoreSectionHeader(title: "アカウント設定")

                ForEach(viewModel.accountMenus) { menu in
                    CrystalCard {
                        HStack(spacing: 10) {
                            Image(systemName: menu.icon)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color(red: 0.40, green: 0.46, blue: 0.55))
                                .frame(width: 30)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(menu.title)
                                    .font(.system(size: 19, weight: .semibold, design: .serif))
                                    .foregroundStyle(StoreTheme.textPrimary)
                                Text(menu.subtitle)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding(.top, 8)
        }
    }
}
