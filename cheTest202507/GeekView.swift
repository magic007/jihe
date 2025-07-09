import SwiftUI

struct GeekView: View {
    // MARK: - Properties
    @State private var searchText = ""
    @State private var selectedTab = "热点"
    @State private var currentBannerPage = 0
    
    // 标签数组
    private let tabs = ["热点", "即刻", "活动", "资讯"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 搜索栏
                searchBar
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                // 标签导航栏
                tabBar
                    .padding(.vertical, 12)
                
                // Banner轮播区
                bannerSection
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                
                // 内容推荐区
                recommendSection
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                
                // 动态详情区
                ForEach(0..<3) { _ in
                    PostCard()
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                }
            }
        }
        .background(Color(hex: "#FFFFFF"))
    }
    
    // MARK: - 搜索栏
    private var searchBar: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("搜索你感兴趣的内容", text: $searchText)
                    .font(.system(size: 14))
            }
            .padding(8)
            .background(Color(hex: "#F5F5F5"))
            .cornerRadius(8)
            
            Button(action: {
                // 处理发布操作
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
            }
        }
    }
    
    // MARK: - 标签导航栏
    private var tabBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(tabs, id: \.self) { tab in
                    VStack(spacing: 4) {
                        Text(tab)
                            .font(.system(size: 16, weight: selectedTab == tab ? .bold : .regular))
                            .foregroundColor(selectedTab == tab ? .black : .gray)
                        
                        Rectangle()
                            .fill(selectedTab == tab ? Color.black : Color.clear)
                            .frame(height: 2)
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedTab = tab
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Banner轮播区
    private var bannerSection: some View {
        TabView(selection: $currentBannerPage) {
            // Banner 1
            BannerCard(
                title: "长按添加 核你玩 车友大集结",
                subtitle: "LIFE AMPLIFIED",
                hasQRCode: true
            )
            .tag(0)
            
            // Banner 2
            BannerCard(
                title: "ZEEHO 创作激励计划 第一期",
                subtitle: "(TIME) 07.02 - 07.31",
                hasQRCode: false
            )
            .tag(1)
        }
        .frame(height: UIScreen.main.bounds.height / 5)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
    
    // MARK: - 内容推荐区
    private var recommendSection: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ], spacing: 12) {
            RecommendCard(
                title: "E Z4",
                subtitle: "大才大用",
                tag: "极核指南",
                gradientColors: [Color(hex: "4FACFE"), Color(hex: "00F2FE")]
            )
            
            RecommendCard(
                title: "",
                subtitle: "",
                tag: "用户声音",
                gradientColors: [Color(hex: "FF6B6B"), Color(hex: "FF8E8E")]
            )
        }
    }
}

// MARK: - Banner卡片组件
struct BannerCard: View {
    let title: String
    let subtitle: String
    let hasQRCode: Bool
    
    var body: some View {
        ZStack {
            // 背景渐变
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "6B77E8"),
                    Color(hex: "4F5DFE"),
                    Color(hex: "8E44AD")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                if hasQRCode {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .cornerRadius(12)
    }
}

// MARK: - 推荐卡片组件
struct RecommendCard: View {
    let title: String
    let subtitle: String
    let tag: String
    let gradientColors: [Color]
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // 背景渐变
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                
                Text(tag)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(4)
            }
            .padding()
        }
        .frame(height: 160)
        .cornerRadius(8)
    }
}

// MARK: - 动态卡片组件
struct PostCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 作者信息栏
            HStack {
                // 头像
                Circle()
                    .fill(Color(hex: "FF9999"))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("极有料")
                        .font(.system(size: 16, weight: .bold))
                    
                    Text("2025.07.08 09:55")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    // 处理聊天操作
                }) {
                    Text("聊天")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .cornerRadius(4)
                }
            }
            
            // 动态文案
            Text("光和影，都只是 AE7 的配色")
                .font(.system(size: 16))
            
            // 图片网格
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8)
            ], spacing: 8) {
                ForEach(0..<4) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [
                                Color(hex: "6B77E8"),
                                Color(hex: "4F5DFE")
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            
            // 互动栏
            HStack(spacing: 24) {
                InteractionButton(icon: "bookmark", count: "718")
                InteractionButton(icon: "message", count: "28")
                InteractionButton(icon: "hand.thumbsup", count: "787")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - 互动按钮组件
struct InteractionButton: View {
    let icon: String
    let count: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.gray)
            Text(count)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    GeekView()
} 