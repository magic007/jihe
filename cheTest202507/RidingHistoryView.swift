import SwiftUI

struct RidingHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMonth = 2 // 0: 5月, 1: 6月, 2: 本月
    
    private let months = ["2025年5月", "06月", "本月"]
    
    var body: some View {
        ZStack {
            Color(hex: "#F5F5F5") // 背景色
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 顶部导航栏
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    Text("历史轨迹")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                    // 为了保持对称
                    Color.clear
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 16)
                }
                .frame(height: 44)
                .background(Color.white)
                
                // 月份选择
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(0..<3) { index in
                            Button(action: {
                                withAnimation {
                                    selectedMonth = index
                                }
                            }) {
                                VStack(spacing: 4) {
                                    Text(months[index])
                                        .font(.system(size: 16))
                                        .foregroundColor(selectedMonth == index ? .black : .gray)
                                        .fontWeight(selectedMonth == index ? .bold : .regular)
                                    
                                    Rectangle()
                                        .fill(selectedMonth == index ? Color.black : Color.clear)
                                        .frame(height: 2)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 12)
                .background(Color.white)
                
                // 骑行记录列表
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(0..<10) { dayIndex in
                            RidingDayCard(date: mockDate(for: dayIndex),
                                        totalDistance: mockTotalDistance(for: dayIndex),
                                        records: mockRecords(for: dayIndex))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    // 模拟日期生成
    private func mockDate(for dayIndex: Int) -> String {
        let day = 9 - dayIndex
        return String(format: "07月%02d日", day)
    }
    
    // 模拟总里程生成
    private func mockTotalDistance(for dayIndex: Int) -> Double {
        let baseDistances = [12.6, 24.2, 28.4, 15.8, 19.3, 22.1, 17.5, 26.8, 20.4, 23.7]
        return baseDistances[dayIndex]
    }
    
    // 模拟数据生成
    private func mockRecords(for dayIndex: Int) -> [RidingRecord] {
        switch dayIndex {
        case 0:
            return [
                RidingRecord(startTime: "09:12", endTime: "09:14", distance: 0.6, duration: 2, speed: 36),
                RidingRecord(startTime: "15:30", endTime: "16:15", distance: 12.0, duration: 45, speed: 42)
            ]
        case 1:
            return [
                RidingRecord(startTime: "15:08", endTime: "15:28", distance: 12.2, duration: 21, speed: 88),
                RidingRecord(startTime: "18:20", endTime: "19:00", distance: 12.0, duration: 40, speed: 55)
            ]
        case 2:
            return [
                RidingRecord(startTime: "10:30", endTime: "11:15", distance: 28.4, duration: 45, speed: 75)
            ]
        case 3:
            return [
                RidingRecord(startTime: "08:00", endTime: "08:45", distance: 15.8, duration: 45, speed: 45),
                RidingRecord(startTime: "17:30", endTime: "17:50", distance: 5.2, duration: 20, speed: 38)
            ]
        case 4:
            return [
                RidingRecord(startTime: "14:20", endTime: "15:10", distance: 19.3, duration: 50, speed: 52)
            ]
        case 5:
            return [
                RidingRecord(startTime: "07:30", endTime: "08:15", distance: 12.1, duration: 45, speed: 40),
                RidingRecord(startTime: "16:00", endTime: "16:40", distance: 10.0, duration: 40, speed: 35)
            ]
        case 6:
            return [
                RidingRecord(startTime: "11:00", endTime: "11:45", distance: 17.5, duration: 45, speed: 48)
            ]
        case 7:
            return [
                RidingRecord(startTime: "09:30", endTime: "10:30", distance: 26.8, duration: 60, speed: 65)
            ]
        case 8:
            return [
                RidingRecord(startTime: "13:15", endTime: "14:00", distance: 20.4, duration: 45, speed: 58)
            ]
        default:
            return [
                RidingRecord(startTime: "10:00", endTime: "10:45", distance: 23.7, duration: 45, speed: 62)
            ]
        }
    }
}

// 单日骑行记录卡片
struct RidingDayCard: View {
    let date: String
    let totalDistance: Double
    let records: [RidingRecord]
    
    var body: some View {
        VStack(spacing: 0) {
            // 日期标题行
            HStack {
                Text(date)
                    .font(.system(size: 16, weight: .bold))
                
                Spacer()
                
                Text("总里程 ")
                    .font(.system(size: 14))
                    + Text("\(String(format: "%.1f", totalDistance))")
                    .font(.system(size: 18, weight: .bold))
                    + Text(" km")
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            // 骑行记录列表
            ForEach(records, id: \.startTime) { record in
                RidingRecordRow(record: record)
            }
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

// 单条骑行记录行
struct RidingRecordRow: View {
    let record: RidingRecord
    
    var body: some View {
        HStack(spacing: 12) {
            // 地图缩略图
            MapThumbnail()
                .frame(width: 60, height: 60)
            
            // 中间信息区
            VStack(alignment: .leading, spacing: 4) {
                Text("\(record.startTime) – \(record.endTime)")
                    .font(.system(size: 14))
                
                Text("\(record.distance < 1 ? "\(Int(record.distance * 1000))m" : String(format: "%.1f", record.distance) + "km")")
                    .font(.system(size: 18, weight: .bold))
                
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("\(record.duration)min")
                            .font(.system(size: 12))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "speedometer")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("\(record.speed)km/h")
                            .font(.system(size: 12))
                    }
                }
            }
            
            Spacer()
            
            // 右侧对勾图标
            Circle()
                .strokeBorder(Color(hex: "#CCCCCC"), lineWidth: 1)
                .frame(width: 20, height: 20)
                .overlay(
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

// 地图缩略图
struct MapThumbnail: View {
    var body: some View {
        ZStack {
            Color(hex: "#F8F8F8")
            Path { path in
                path.move(to: CGPoint(x: 15, y: 45))
                path.addCurve(
                    to: CGPoint(x: 45, y: 15),
                    control1: CGPoint(x: 20, y: 25),
                    control2: CGPoint(x: 40, y: 35)
                )
            }
            .stroke(Color(hex: "#1890FF"), lineWidth: 2)
        }
        .cornerRadius(4)
    }
}

// 骑行记录数据模型
struct RidingRecord {
    let startTime: String
    let endTime: String
    let distance: Double // 单位：km
    let duration: Int // 单位：min
    let speed: Int // 单位：km/h
}

#Preview {
    RidingHistoryView()
} 