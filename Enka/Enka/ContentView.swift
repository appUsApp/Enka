import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SeafoodStoreViewModel()

    var body: some View {
        ZStack {
            StoreBackgroundView()

            VStack(spacing: 0) {
                Group {
                    switch viewModel.appScreen {
                    case .home:
                        HomeView(viewModel: viewModel)
                    case .campaign:
                        CampaignView(viewModel: viewModel)
                    case .cart:
                        CartView(viewModel: viewModel)
                    case .account:
                        AccountView(viewModel: viewModel)
                    case .categoryProducts:
                        CategoryProductsView(viewModel: viewModel)
                    case .productDetail:
                        ProductDetailView(viewModel: viewModel)
                    case .orderConfirmed:
                        OrderConfirmedView(viewModel: viewModel)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                StoreBottomNavBar(appScreen: viewModel.appScreen) { destination in
                    viewModel.moveTo(destination)
                }
                .padding(.top, 10)
            }
            .padding(14)
        }
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
