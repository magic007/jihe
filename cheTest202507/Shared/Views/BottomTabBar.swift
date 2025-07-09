import SwiftUI

struct BottomTabBar: View {
    let selectedTab: Int
    var onTabSelected: ((Int) -> Void)?
    
    init(selectedTab: Int, onTabSelected: ((Int) -> Void)? = nil) {
        self.selectedTab = selectedTab
        self.onTabSelected = onTabSelected
    }
    
    var body: some View {
        HStack {
            TabItem(icon: "scooter", title: "极车", isSelected: selectedTab == 0)
                .onTapGesture { onTabSelected?(0) }
            
            TabItem(icon: "checkmark.shield", title: "服务", isSelected: selectedTab == 1)
                .onTapGesture { onTabSelected?(1) }
            
            TabItem(icon: "atom", title: "极客", isSelected: selectedTab == 2)
                .onTapGesture { onTabSelected?(2) }
            
            TabItem(icon: "bag", title: "极市", isSelected: selectedTab == 3)
                .onTapGesture { onTabSelected?(3) }
            
            TabItem(icon: "person", title: "我的", isSelected: selectedTab == 4)
                .onTapGesture { onTabSelected?(4) }
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.2)),
            alignment: .top
        )
    }
}

private struct TabItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 22))
            Text(title)
                .font(.system(size: isSelected ? 14 : 12))
        }
        .foregroundColor(isSelected ? .black : .gray)
        .frame(maxWidth: .infinity)
    }
} 