import SwiftUI

struct ServiceView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 背景渐变色
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "#F8F8F8"), .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // 顶部标题栏
                    HStack {
                        Text("车主服务")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                        Image(systemName: "headphones.circle")
                            .font(.system(size: 24))
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            // 车主服务功能区
                            ServiceGridView()
                            
                            // 在线客服模块
                            CustomerServiceCard()
                            
                            // 极智服务模块
                            SmartServiceCard()
                            
                            // 附近门店
                            NearbyStoresSection()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// 车主服务功能网格
struct ServiceGridView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                ServiceGridItem(icon: "doc.fill", title: "使用指南", hasYellowDecoration: true)
                ServiceGridItem(icon: "shield.fill", title: "防盗功能", hasYellowDecoration: true)
                ServiceGridItem(icon: "chart.line.uptrend.xyaxis", title: "车辆体检", hasYellowDecoration: true)
                ServiceGridItem(icon: "arrow.up.square.fill", title: "OTA升级", hasYellowDecoration: true)
            }
            
            HStack(spacing: 0) {
                ServiceGridItem(icon: "calendar", title: "预约保养", hasYellowDecoration: true)
                ServiceGridItem(icon: "wrench.fill", title: "故障报修", hasYellowDecoration: true)
                ServiceGridItem(icon: "creditcard.fill", title: "配件价格", hasYellowDecoration: true)
                ServiceGridItem(icon: "doc.text.fill", title: "三包政策", hasYellowDecoration: true)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// 单个服务网格项
struct ServiceGridItem: View {
    let icon: String
    let title: String
    let hasYellowDecoration: Bool
    
    var body: some View {
        if title == "使用指南" {
            NavigationLink(destination: ServiceGuideView()) {
                gridItemContent
            }
        } else {
            gridItemContent
        }
    }
    
    private var gridItemContent: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color(hex: "#007AFF"))
                    .frame(width: 50, height: 50)
                
                if hasYellowDecoration {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 10, height: 10)
                        .offset(x: 15, y: -15)
                }
                
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

// 在线客服卡片
struct CustomerServiceCard: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("在线客服")
                    .font(.system(size: 18, weight: .bold))
                Text("有任何问题，请联系我们的客服")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// 极智服务卡片
struct SmartServiceCard: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("zeeho_motorcycle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("鹏大哥的宝马")
                    .font(.system(size: 18, weight: .bold))
                Text("智能服务有效期至：")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                Text("2027-08-15")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#007AFF"))
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("去充值")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#007AFF"))
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// 附近门店区域
struct NearbyStoresSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("附近门店")
                    .font(.system(size: 20, weight: .bold))
                
                HStack(spacing: 4) {
                    Text("广州市")
                        .foregroundColor(Color(hex: "#007AFF"))
                    Image(systemName: "location.fill")
                        .foregroundColor(Color(hex: "#007AFF"))
                }
                
                Spacer()
            }
            
            // 多个门店卡片
            VStack(spacing: 12) {
                StoreCard(
                    status: "正常营业",
                    name: "ZEEHO 极核电动 (广州碁龙西路店)(试营业)",
                    address: "广州市番禺区大龙街道碁龙西路86-1、-2",
                    distance: "1.94km",
                    phone: "020-12345678",
                    businessHours: "10:00-22:00"
                )
                
                StoreCard(
                    status: "正常营业",
                    name: "ZEEHO 极核电动 (广州天河店)",
                    address: "广州市天河区天河路299号",
                    distance: "3.2km",
                    phone: "020-87654321",
                    businessHours: "09:30-21:30"
                )
                
                StoreCard(
                    status: "休息中",
                    name: "ZEEHO 极核电动 (广州珠江新城店)",
                    address: "广州市天河区珠江新城华夏路10号",
                    distance: "4.5km",
                    phone: "020-98765432",
                    businessHours: "10:00-21:00"
                )
            }
        }
    }
}

// 门店卡片
struct StoreCard: View {
    let status: String
    let name: String
    let address: String
    let distance: String
    let phone: String
    let businessHours: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 状态标签
            HStack {
                Text(status)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(status == "正常营业" ? Color(hex: "#007AFF") : Color.gray)
                    .cornerRadius(4)
                Spacer()
            }
            
            // 店名
            Text(name)
                .font(.system(size: 16, weight: .bold))
            
            // 标签和评分
            HStack(spacing: 8) {
                Text("销售")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray)
                    .cornerRadius(4)
                
                Text("服务")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray)
                    .cornerRadius(4)
                
                HStack(spacing: 2) {
                    Text("★★★★★")
                        .foregroundColor(.purple)
                    Text("10.0")
                        .foregroundColor(.purple)
                }
            }
            
            // 门店信息
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.gray)
                    Text(address)
                        .font(.system(size: 14))
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "location.circle")
                        .foregroundColor(.gray)
                    Text(distance)
                        .font(.system(size: 14))
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text("营业时间：\(businessHours)")
                        .font(.system(size: 14))
                }
            }
            
            Divider()
                .padding(.vertical, 8)
            
            // 底部按钮
            HStack(spacing: 12) {
                // 导航按钮
                Button(action: {
                    // 处理导航操作
                }) {
                    HStack {
                        Image(systemName: "map")
                            .foregroundColor(Color(hex: "#007AFF"))
                        Text("导航")
                            .foregroundColor(Color(hex: "#007AFF"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color(hex: "#007AFF").opacity(0.1))
                    .cornerRadius(8)
                }
                
                // 电话按钮
                Button(action: {
                    // 处理电话操作
                    if let url = URL(string: "tel://\(phone.replacingOccurrences(of: "-", with: ""))") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(Color(hex: "#007AFF"))
                        Text("电话")
                            .foregroundColor(Color(hex: "#007AFF"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color(hex: "#007AFF").opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
} 