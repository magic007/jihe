import SwiftUI

// 顶部工具栏视图
struct TopToolbarView: View {
    var body: some View {
        HStack {
            Image(systemName: "qrcode")
                .font(.system(size: 22))
            Spacer()
            HStack(spacing: 20) {
                Image(systemName: "gearshape")
                    .font(.system(size: 22))
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 22))
            }
        }
        .padding(.horizontal)
        .foregroundColor(.black)
    }
}

// 用户头像和信息视图
struct UserProfileHeaderView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // 头像
            ZStack {
                Circle()
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.purple.opacity(0.6), .blue.opacity(0.6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
                    .frame(width: 80, height: 80)
                
                Image("zeeho_motorcycle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 76, height: 76)
                    .clipShape(Circle())
                
                // 认证标识
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 20, height: 20)
                    Text("V")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
                .offset(x: 30, y: 30)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("会飞的小猪")
                    .font(.system(size: 20, weight: .bold))
                Text("极核号：6297756399")
                    .font(.system(size: 14))
                Text("够酷才是我的生活态度")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 30)
    }
}

// 数据统计视图
struct StatsView: View {
    var body: some View {
        HStack {
            ForEach(["发帖", "关注", "粉丝"], id: \.self) { item in
                VStack(spacing: 8) {
                    Text("1")
                        .font(.system(size: 20, weight: .medium))
                    Text(item)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 15)
    }
}

// 积分和签到卡片视图
struct PointsAndCheckInView: View {
    var body: some View {
        HStack(spacing: 15) {
            // 积分模块
            PointsCardView()
            // 签到模块
            CheckInCardView()
        }
        .padding(.horizontal)
    }
}

// 积分卡片视图
struct PointsCardView: View {
    var body: some View {
        NavigationLink(destination: PointsView()) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 40, height: 40)
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: 24))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("227")
                        .font(.system(size: 18, weight: .medium))
                    Text("可用积分")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// 签到卡片视图
struct CheckInCardView: View {
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 40, height: 40)
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                    .font(.system(size: 24))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("签到")
                    .font(.system(size: 18, weight: .medium))
                Text("签到有惊喜")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
    }
}

// 功能菜单列表视图
struct MenuListView: View {
    let menuItems = [
        ("car.2.fill", "我的车库"),
        ("wrench.and.screwdriver.fill", "我的服务"),
        ("doc.text.fill", "我的订单"),
        ("exclamationmark.bubble.fill", "APP反馈"),
        ("info.circle.fill", "关于APP")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(menuItems, id: \.1) { icon, title in
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .frame(width: 30)
                    
                    Text(title)
                        .font(.system(size: 16))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(Color.white)
                
                if title != "关于APP" {
                    Divider()
                        .padding(.leading, 60)
                }
            }
        }
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// 积分币图标视图
struct PointsCoinIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.orange)
                .frame(width: 24, height: 24)
            
            // 三层积分币线条
            ForEach(0..<3) { index in
                Circle()
                    .strokeBorder(Color.white, lineWidth: 1)
                    .frame(width: CGFloat(18 - index * 4), height: CGFloat(18 - index * 4))
            }
        }
    }
}

// 积分任务项视图改进版
struct PointsTaskItemView: View {
    let title: String
    let points: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                Text(points)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.blue)
                Spacer()
                Button(action: {
                    // 前往任务操作
                }) {
                    Text("前往")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .frame(width: 60, height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
            }
            
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.6))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(6)
    }
}

// 积分规则页面视图改进版
struct PointsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let tasks = [
        ("首次绑定车辆", "+1000~3000", "车辆首绑后依车型奖励1000~3000积分"),
        ("车主生日", "+200", "仅限车主，生日当天发放"),
        ("推荐注册", "+10", "每次推荐用户注册APP奖励10积分"),
        ("优质图文", "+500", "每次原创帖被推荐奖励500积分"),
        ("每日首次发帖", "+1", "每日首次发帖可获得1积分"),
        ("分享内容", "+1", "每次分享内容可获得1积分，每日上限1次 (0/1)")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 顶部导航栏
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    NavigationLink(destination: PointsRuleView()) {
                        Text("积分规则")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                // 积分概览卡片
                VStack(spacing: 0) {
                    HStack {
                        PointsCoinIcon()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("227")
                                .font(.system(size: 28, weight: .bold))
                            Text("当前可用积分")
                                .font(.system(size: 14))
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding(.leading, 8)
                        
                        Spacer()
                        
                        NavigationLink(destination: Text("积分记录页面")) {
                            HStack(spacing: 4) {
                                Text("积分记录")
                                    .font(.system(size: 14))
                                    .foregroundColor(.blue)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                }
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.bottom, 24)
                
                // 积分任务列表
                VStack(spacing: 12) {
                    ForEach(tasks, id: \.0) { task in
                        PointsTaskItemView(title: task.0, points: task.1, description: task.2)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .navigationBarHidden(true)
    }
}

// 主视图
struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TopToolbarView()
                    UserProfileHeaderView()
                    StatsView()
                    PointsAndCheckInView()
                    MenuListView()
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGray6))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }
}

struct ProfileView2_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
