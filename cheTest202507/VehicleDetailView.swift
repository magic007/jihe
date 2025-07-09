//
//  VehicleDetailView.swift
//  cheTest202507
/**
帮忙新建一个页面二，中部核心展示区

车辆展示图：
居中显示一辆电动摩托车的高精度渲染图，车辆主体为白、黑配色，车身上有 "ZEEHO" 等装饰文字 / 标识；
图片清晰呈现车辆外观细节（如车身线条、车轮、座椅、把手等 ），光影效果模拟真实拍摄质感，突出科技与产品质感，占据界面横向主要宽度，纵向合理留白，让视觉聚焦车辆。
位置信息栏：
车辆图下方，显示带地图定位图标的地址信息 "黄埔融创知识城一街 24 号" ；
地图定位图标为蓝白配色（类似 iOS 地图定位标识 ），文字为黑色无衬线字体，字号适中，整体模块为浅灰色圆角矩形底色，与背景区分开，清晰展示车辆当前关联位置。
功能数据区（卡片式布局 ）

左侧数据卡片：
两个数据项纵向排列，均为白色圆角矩形卡片，浅灰色边框分割：
第一项 "预估里程" ：标题文字为灰色小字，内容 "80 km" 为黑色大号字体，突出显示；
第二项 "剩余电量" ：标题文字灰色小字，内容 "85 %" 黑色大号字体，下方配浅蓝色进度条（模拟电量进度 ），进度条长度与电量数值关联，直观展示剩余电量状态。
右侧功能按钮卡片：
四个功能按钮呈 2×2 网格排列，白色圆角矩形卡片，浅灰色边框分割，每个按钮包含：
矢量图标（黑色简洁风格 ） + 黑色小字标题：
"长按开锁" ：锁形图标；
"孪生仪表" ：类似仪表盘 / 屏幕叠加图标；
"车辆设置" ：齿轮形设置图标；
"寻车" ：喇叭 / 声波扩散形图标；
按钮可点击区域明确，符合 iOS 交互习惯，图标与文字居中对齐，简洁易识别。
骑行数据统计区

标题与模块：
标题 "我的骑行" 为黑色加粗无衬线字体，左对齐，下方是浅灰色横线分隔；
模块为白色圆角矩形卡片，包含三项骑行数据，横向排列，浅灰色边框 / 留白区分：
"8h3min 本月总时长" ：数值 "8h3min" 为黑色大号字体，描述文字 "本月总时长" 灰色小字，居左；
"213.3 km 本月行驶距离" ：数值 "213.3 km" 黑色大号字体，描述文字灰色小字，居中；
"26 km/h 本月行驶均速" ：数值 "26 km/h" 黑色大号字体，描述文字灰色小字，居右；
数据清晰分类，满足用户快速查看骑行统计需求，字体、配色延续整体风格，保证视觉统一。
*/
//  Created by 张文博 on 2025/7/8.
//

import SwiftUI

struct RidingStatistics {
    var totalTime: String
    var totalDistance: String
    var averageSpeed: String
}

struct StatisticItem: View {
    var value: String
    var description: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 18, weight: .bold))
            Text(description)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct VehicleDetailView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 车辆基本信息
                VehicleBasicInfo()
                
                // 功能按钮组
                VehicleFunctionButtons()
                
                // 详细信息列表
                VehicleDetailList()
            }
            .padding()
        }
        .navigationTitle("车辆详情")
    }
}

// MARK: - Supporting Views
struct VehicleBasicInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 车辆图片
            Image("zeeho_motorcycle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            
            // 车辆名称和状态
            HStack {
                Text("ZEEHO AE8")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("已绑定")
                    .foregroundColor(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
            }
            
            // 车辆编号
            Text("车辆编号：ZH2024001")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct VehicleFunctionButtons: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 20) {
                VehicleDetailButton(
                    icon: "key.fill",
                    label: "授权管理",
                    action: { /* 授权管理逻辑 */ }
                )
                VehicleDetailButton(
                    icon: "doc.text.fill",
                    label: "行驶证照",
                    action: { /* 行驶证照逻辑 */ }
                )
            }
            
            HStack(spacing: 20) {
                VehicleDetailButton(
                    icon: "bell.fill",
                    label: "报警记录",
                    action: { /* 报警记录逻辑 */ }
                )
                VehicleDetailButton(
                    icon: "location.fill",
                    label: "行驶轨迹",
                    action: { /* 行驶轨迹逻辑 */ }
                )
            }
        }
    }
}

struct VehicleDetailButton: View {
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
                    .frame(width: 44, height: 44)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
                
                Text(label)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct VehicleDetailList: View {
    var body: some View {
        VStack(spacing: 1) {
            DetailRow(title: "车架号", value: "LZSL1234567890")
            DetailRow(title: "电机号", value: "M123456")
            DetailRow(title: "购车日期", value: "2024-01-15")
            DetailRow(title: "保修期限", value: "2026-01-14")
            DetailRow(title: "经销商", value: "杭州未来科技城店")
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.white)
    }
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView()
    }
} 