import SwiftUI

// MARK: - 粒子系统
struct ParticleSystem: View {
    let particleCount: Int
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<particleCount, id: \.self) { _ in
                Particle(size: geometry.size)
            }
        }
    }
}

struct Particle: View {
    let size: CGSize
    
    @State private var position: CGPoint
    @State private var scale: CGFloat
    @State private var opacity: Double
    
    init(size: CGSize) {
        self.size = size
        _position = State(initialValue: CGPoint(
            x: .random(in: 0...size.width),
            y: -20
        ))
        _scale = State(initialValue: .random(in: 0.5...1.0))
        _opacity = State(initialValue: .random(in: 0.5...1.0))
    }
    
    var body: some View {
        Circle()
            .fill(Color.blue.opacity(0.3))
            .frame(width: 8, height: 8)
            .scaleEffect(scale)
            .opacity(opacity)
            .position(position)
            .onAppear {
                withAnimation(
                    .linear(duration: .random(in: 3...5))
                    .repeatForever(autoreverses: false)
                ) {
                    position = CGPoint(
                        x: .random(in: 0...size.width),
                        y: size.height + 20
                    )
                }
                
                withAnimation(
                    .linear(duration: .random(in: 1...2))
                    .repeatForever(autoreverses: true)
                ) {
                    scale = .random(in: 0.5...1.0)
                    opacity = .random(in: 0.5...1.0)
                }
            }
    }
}

struct HomeView: View {
    var body: some View {
        ZStack {
            // 背景渐变
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#E6F3FF"), // 浅蓝色
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // 主要内容
            VStack(spacing: 20) {
                // 车辆展示区
                VehicleDisplaySection()
                
                // 定位信息
                LocationSection()
                
                // 数据与功能区
                HStack(alignment: .top, spacing: 15) {
                    // 左侧数据
                    DataSection()
                    
                    // 右侧功能按钮
                    FunctionButtonsSection()
                }
                .padding(.horizontal)
                
                // 骑行统计
                RidingStatsSection()
                
                Spacer()
            }
        }
    }
}

// MARK: - 车辆展示区
struct VehicleDisplaySection: View {
    var body: some View {
        ZStack {
            // 粒子效果
            ParticleSystem(particleCount: 100)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
            
            Image("zeeho_motorcycle")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        }
        .padding(.top, 40)
    }
}

// MARK: - 定位信息
struct LocationSection: View {
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(Color(hex: "#4A90E2"))
            
            Text("黄埔融创知识城一街24号")
                .foregroundColor(Color(hex: "#333333"))
                .font(.system(size: 16))
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// MARK: - 数据区域
struct DataSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            // 预估里程
            VStack(alignment: .leading, spacing: 5) {
                Text("预估里程")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                
                HStack(alignment: .bottom, spacing: 2) {
                    Text("80")
                        .font(.system(size: 36, weight: .bold))
                    Text("km")
                        .font(.system(size: 16))
                        .padding(.bottom, 4)
                }
            }
            
            // 剩余电量
            VStack(alignment: .leading, spacing: 5) {
                Text("剩余电量")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                
                HStack(alignment: .bottom, spacing: 2) {
                    Text("85")
                        .font(.system(size: 36, weight: .bold))
                    Text("%")
                        .font(.system(size: 16))
                        .padding(.bottom, 4)
                }
                
                // 电量进度条
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 4)
                            .opacity(0.2)
                            .foregroundColor(.gray)
                        
                        Rectangle()
                            .frame(width: geometry.size.width * 0.85, height: 4)
                            .foregroundColor(Color(hex: "#4A90E2"))
                    }
                }
                .frame(height: 4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
    }
}

// MARK: - 功能按钮区域
struct FunctionButtonsSection: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 15) {
            FunctionButton(icon: "lock", title: "长按开锁")
            FunctionButton(icon: "speedometer", title: "孪生仪表")
            FunctionButton(icon: "gearshape", title: "车辆设置")
            FunctionButton(icon: "speaker.wave.2", title: "寻车")
        }
    }
}

// MARK: - 骑行统计区域
struct RidingStatsSection: View {
    @State private var showRidingView = false
    
    var body: some View {
        VStack(spacing: 15) {
            Button(action: {
                showRidingView = true
            }) {
                HStack {
                    Text("我的骑行")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                StatItem(value: "8h3min", title: "本月总时长")
                StatItem(value: "213.3 km", title: "本月行驶距离")
                StatItem(value: "26 km/h", title: "本月行驶均速")
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .padding(.horizontal)
        .sheet(isPresented: $showRidingView) {
            RidingView()
        }
    }
}

struct StatItem: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.system(size: 18, weight: .bold))
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 