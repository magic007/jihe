//
//  ContentView.swift
//  cheTest202507
//
//  Created by magic on 2025/7/8.
/**
你是一位资深APP UI设计师，App 程序员，现需根据以下产品需求创建UI方案，最终生成IOS 页面完整代码：
## 产品需求：
应用类型：电动车管理
### 核心模块：
实现首页，展示电动车相关参数信息，模拟数据，包括rideMileageMonth
String
列注释： 单月平均骑行距离
默认值：未设置
chargeState
Number
列注释： 充电状态
默认值：未设置
location
Geopoint
列注释： 车辆位置
默认值：未设置
address
String
列注释： 当前地址
默认值：位置
bmssoc
Number
列注释： 电量
默认值：未设置
ridingTimeMonth
String
列注释： 单月平均骑行时间
默认值：未设置
locationTime
String
列注释： 停留时间
默认值：未设置
avgVelocityMonth
String
列注释： 单月平均速度
默认值：未设置
altitude
Number
列注释： 海拔
默认值：未设置
bmsSocDifference
Number
列注释： 充电后使用的电量
默认值：未设置
mileageDifference
Number
列注释： 充电后使用的续航
默认值：未设置
lastFullChargeSoc
Number
列注释： 最近充满电量
默认值：未设置
系统字段
objectId
String系统字段
列注释：数据唯一标识，由系统自动生成
createdAt
Date系统字段
列注释：创建时间，由系统自动生成
updatedAt
Date系统字段
列注释：更新时间，由系统自动更新


## 技术规格：
单个IOS 页面每行为4个横向排列的页面预览，可以有多行；代码需要包含所有功能页面；
▸ 画板尺寸：375x812（带1px描边模拟手机边框）；
▸ 必须包含：
矢量图标系统（使用<symbol>定义）
动态折线图（stroke-dasharray动画）
卡片悬浮效果（通过filter实现）
## 新视觉风格：3D风设计（Neumorphism）
1. 立体感与空间感
真实的深度效果：利用阴影、光影和透视原理，营造出强烈的空间层次感。
分层设计：界面中的元素分层摆放，前景、背景和中间内容清晰分离，突出层次感，结合简洁的3D效果与2D风格图标。
Z轴设计：不仅关注X/Y轴的平面布局，还注重Z轴的深度表现。
2. 光影与材质
动态光影：通过实时光照和阴影变化，增强画面的真实感。
材质细节：使用仿真的材质效果（如金属、玻璃、木纹等），让元素看起来更加真实。
反射与折射：部分设计中加入反射、透明和折射效果，提升科技感和视觉冲击力。
3. 色彩与渐变
丰富的渐变色：渐变色广泛应用于背景或元素上，增强立体感和未来感。
亮暗对比：通过明暗对比突出重点，增加视觉冲击力。
真实色彩还原：色彩搭配更加贴近自然世界的真实效果。
4. 动态与交互
微交互：3D元素在用户操作时会有轻微的动态反馈，如旋转、缩放或弹跳。
动画效果：常见的3D动画包括元素的翻转、旋转、移动等，提升趣味性。
沉浸式体验：通过3D场景的动态变化，让用户感觉自己置身于一个虚拟空间中。
5. 图标与元素
立体化图标：图标和按钮设计成3D样式，增强视觉冲击力。
仿真物体：界面中的元素可能直接模仿真实物体，例如3D模型的开关、按钮等。
粒子效果：常用粒子动态效果（如漂浮、散射），让界面更具科技感和未来感。
6. 布局与导航
模块式布局：内容分区清晰，模块之间通过空间感隔离。
旋转视角：部分APP允许用户通过滑动或点击改变视角，探索3D空间。
场景化设计：界面可能以一个完整的3D场景呈现，用户在其中进行交互。
3D风格的文字通过光影、渐变、纹理和透视效果营造出立体感，呈现出具有深度、层次和空间感的视觉效果。
*/ 
//

import SwiftUI
import Charts

struct NeumorphicStyle {
    static let backgroundColor = Color(red: 241/255, green: 243/255, blue: 248/255)
    static let shadowColor = Color.black.opacity(0.2)
    static let highlightColor = Color.white.opacity(0.8)
    static let gradientStart = Color(red: 247/255, green: 249/255, blue: 253/255)
    static let gradientEnd = Color(red: 237/255, green: 239/255, blue: 244/255)
}

struct VehicleData {
    var rideMileageMonth: String
    var chargeState: Int
    var address: String
    var bmssoc: Int
    var ridingTimeMonth: String
    var locationTime: String
    var avgVelocityMonth: String
    var altitude: Int
    var bmsSocDifference: Int
    var mileageDifference: Int
    var lastFullChargeSoc: Int
}

struct NeumorphicCard: View {
    var title: String
    var value: String
    var icon: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 4)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(NeumorphicStyle.backgroundColor)
                .shadow(color: NeumorphicStyle.shadowColor, radius: 10, x: 10, y: 10)
                .shadow(color: NeumorphicStyle.highlightColor, radius: 10, x: -5, y: -5)
        )
        .padding(8)
    }
}

struct BatteryView: View {
    var percentage: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            NeumorphicStyle.gradientStart,
                            NeumorphicStyle.gradientEnd
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)
                .shadow(color: NeumorphicStyle.shadowColor, radius: 10, x: 10, y: 10)
                .shadow(color: NeumorphicStyle.highlightColor, radius: 10, x: -5, y: -5)
            
            VStack {
                Image(systemName: "battery.100")
                    .font(.system(size: 60))
                    .foregroundColor(percentage > 20 ? .green : .red)
                
                Text("\(percentage)%")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
            }
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var vehicleData = VehicleData(
        rideMileageMonth: "150km",
        chargeState: 1,
        address: "上海市浦东新区",
        bmssoc: 85,
        ridingTimeMonth: "25小时",
        locationTime: "2小时",
        avgVelocityMonth: "25km/h",
        altitude: 15,
        bmsSocDifference: 15,
        mileageDifference: 30,
        lastFullChargeSoc: 100
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    NavigationLink(destination: VehicleDetailView()) {
                        // 电池状态
                        BatteryView(percentage: vehicleData.bmssoc)
                    }
                    
                    // 信息卡片网格
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        NeumorphicCard(
                            title: "月均里程",
                            value: vehicleData.rideMileageMonth,
                            icon: "speedometer"
                        )
                        
                        NeumorphicCard(
                            title: "月均时间",
                            value: vehicleData.ridingTimeMonth,
                            icon: "clock"
                        )
                        
                        NeumorphicCard(
                            title: "平均速度",
                            value: vehicleData.avgVelocityMonth,
                            icon: "gauge"
                        )
                        
                        NeumorphicCard(
                            title: "当前位置",
                            value: vehicleData.address,
                            icon: "location"
                        )
                        
                        NeumorphicCard(
                            title: "停留时间",
                            value: vehicleData.locationTime,
                            icon: "timer"
                        )
                        
                        NeumorphicCard(
                            title: "海拔高度",
                            value: "\(vehicleData.altitude)m",
                            icon: "mountain.2"
                        )
                    }
                    
                    // 用电统计
                    VStack {
                        Text("用电统计")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        
                        Chart {
                            LineMark(
                                x: .value("Time", "上次充电"),
                                y: .value("电量", vehicleData.lastFullChargeSoc)
                            )
                            LineMark(
                                x: .value("Time", "当前"),
                                y: .value("电量", vehicleData.bmssoc)
                            )
                        }
                        .frame(height: 200)
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(NeumorphicStyle.backgroundColor)
                            .shadow(color: NeumorphicStyle.shadowColor, radius: 10, x: 10, y: 10)
                            .shadow(color: NeumorphicStyle.highlightColor, radius: 10, x: -5, y: -5)
                    )
                    .padding()
                }
                .padding()
            }
            .background(NeumorphicStyle.backgroundColor.ignoresSafeArea())
        }
    }
}

#Preview {
    ContentView()
}
