import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                ServiceView()
                    .tag(1)
                
                NavigationView {
                    GeekView()
                }
                .tag(2)
                
                MarketView()
                    .tag(3)
                
                ProfileView()
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // 自定义底部导航栏
            BottomTabBar(selectedTab: selectedTab) { index in
                withAnimation {
                    selectedTab = index
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainView()
} 
