import SwiftUI

struct FunctionButton: View {
    let icon: String
    let title: String
    
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
            Text(title)
                .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
    }
} 