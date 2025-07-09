import SwiftUI

struct MarketView: View {
    // 轮播图当前页码
    @State private var currentPage = 1
    // 选中的分类
    @State private var selectedCategory = "骑行装备"
    
    // 分类列表
    let categories = ["骑行装备", "车身专区", "积分专享", "潮流周边", "服务"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 顶部品牌区
                brandHeader
                
                // 轮播图区域
                carouselSection
                
                // 分类导航
                categoryNav
                
                // 商品网格
                productGrid
            }
        }
        .background(Color(hex: "F5F5F5"))
    }
    
    // MARK: - 顶部品牌区
    private var brandHeader: some View {
        HStack {
            // 品牌Logo和标识
            HStack(spacing: 8) {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "cart.fill")
                            .foregroundColor(.white)
                    )
                
                Text("ZEEHO MARKET")
                    .font(.system(size: 12, weight: .light))
                    .kerning(1)
            }
            
            Spacer()
            
            // 购物车图标
            Image(systemName: "cart")
                .font(.system(size: 20))
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white)
    }
    
    // MARK: - 轮播图区域
    private var carouselSection: some View {
        ZStack {
            // 背景渐变
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "6B77E8"), // 主色调：紫色
                    Color(hex: "4F5DFE"), // 过渡色：蓝紫色
                    Color(hex: "8E44AD")  // 结束色：深紫色
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // 装饰性圆形渐变
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.2),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 5,
                        endRadius: 100
                    )
                )
                .frame(width: 200, height: 200)
                .offset(x: 100, y: -50)
                .blur(radius: 20)
            
            // 装饰性线条
            Path { path in
                path.move(to: CGPoint(x: 20, y: 180))
                path.addCurve(
                    to: CGPoint(x: 200, y: 100),
                    control1: CGPoint(x: 50, y: 150),
                    control2: CGPoint(x: 150, y: 120)
                )
            }
            .stroke(Color.white.opacity(0.3), lineWidth: 2)
            
            VStack(alignment: .leading, spacing: 12) {
                // 主标题
                Text("AE4 Max MY25")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                // 副标题
                HStack {
                    Text("低空飞行")
                        .font(.system(size: 16))
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.white)
                
                // 轮播指示器
                HStack(spacing: 8) {
                    ForEach(0..<2) { index in
                        Circle()
                            .fill(Color.white.opacity(index == currentPage ? 1 : 0.5))
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
    
    // MARK: - 分类导航
    private var categoryNav: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(categories, id: \.self) { category in
                    VStack(spacing: 4) {
                        Text(category)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        // 选中状态下显示下划线
                        Rectangle()
                            .fill(selectedCategory == category ? Color.black : Color.clear)
                            .frame(height: 2)
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    // MARK: - 商品网格
    private var productGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ], spacing: 12) {
            // 商品卡片1
            ProductCard(
                brand: "ZEEHO",
                image: "gloves",
                price: 119.00,
                name: "ZEEHO 潮流收紧保暖骑行手套"
            )
            
            // 商品卡片2
            ProductCard(
                brand: "ZEEHO",
                image: "helmet",
                price: 179.00,
                name: "ZEEHO 极核卡通动漫安全头盔",
                priceTag: "起"
            )
            
            // 商品卡片3
            ProductCard(
                brand: "ZEEHO",
                image: "helmet_silver",
                price: 299.00,
                name: "ZEEHO 头盔（银白配色，带护目镜）"
            )
            
            // 商品卡片4
            ProductCard(
                brand: "ZEEHO",
                image: "helmet_black",
                price: 329.00,
                name: "ZEEHO 头盔（黑色，带金色装饰条）"
            )
        }
        .padding()
    }
}

// MARK: - 商品卡片组件
struct ProductCard: View {
    let brand: String
    let image: String
    let price: Double
    let name: String
    var priceTag: String = ""
    
    // 根据商品类型返回不同的渐变色
    private var gradientColors: [Color] {
        switch image {
            case "gloves":
                return [
                    Color(hex: "FF6B6B"),  // 红色
                    Color(hex: "FF8E8E")   // 浅红色
                ]
            case "helmet":
                return [
                    Color(hex: "4FACFE"),  // 蓝色
                    Color(hex: "00F2FE")   // 青色
                ]
            case "helmet_silver":
                return [
                    Color(hex: "43E97B"),  // 绿色
                    Color(hex: "38F9D7")   // 青绿色
                ]
            default:
                return [
                    Color(hex: "FA709A"),  // 粉色
                    Color(hex: "FEE140")   // 黄色
                ]
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 品牌标识
            Text(brand)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
            
            // 商品图片区域替换为渐变背景
            ZStack(alignment: .bottomTrailing) {
                // 主渐变背景
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // 装饰性元素
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .offset(x: -20, y: -20)
                    .blur(radius: 8)
                
                // 根据商品类型显示不同的图标
                Image(systemName: getSystemImage())
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .position(x: 80, y: 80)
                
                // 价格标签
                HStack(spacing: 2) {
                    Text("零售价:")
                    Text("¥\(Int(price))\(priceTag)")
                        .underline()
                }
                .font(.system(size: 12))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .cornerRadius(4)
                .padding(8)
            }
            
            // 商品名称
            Text(name)
                .font(.system(size: 14))
                .lineLimit(1)
                .truncationMode(.tail)
            
            // 售价
            Text("¥\(String(format: "%.2f", price))")
                .font(.system(size: 16, weight: .medium))
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
    }
    
    // 根据商品类型返回对应的系统图标
    private func getSystemImage() -> String {
        switch image {
            case "gloves":
                return "hand.raised.fill"
            case "helmet", "helmet_silver", "helmet_black":
                return "shield.fill"
            default:
                return "star.fill"
        }
    }
}

#Preview {
    MarketView()
} 