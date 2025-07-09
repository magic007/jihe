import SwiftUI
import Charts

struct RidingView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @State private var selectedMonth = "2025年07月"
    @State private var selectedButton: String?
    
    // 颜色定义
    private let backgroundColor = Color(hex: "F5F5F5")
    private let primaryPurple = Color(hex: "6B77E8")
    private let lightPurple = Color(hex: "C6BDEF")
    private let gradientStart = Color(hex: "4F5DFE")
    private let gradientEnd = Color(hex: "8E44AD")
    
    // 示例数据
    private let dailyData = [
        DailyRiding(day: "6", distance: 18.5),
        DailyRiding(day: "7", distance: 15.2),
        DailyRiding(day: "8", distance: 14.0),
        DailyRiding(day: "今日", distance: 12.6)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        navigationBar
                        functionButtons
                        totalDistanceCard
                        monthlyStatistics
                        todayDataCard
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Navigation Bar
    private var navigationBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text("我的骑行")
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
            
            // 为了保持对称，添加一个占位视图
            Color.clear.frame(width: 18, height: 18)
        }
        .padding(.top)
    }
    
    // MARK: - Function Buttons
    private var functionButtons: some View {
        HStack(spacing: 12) {
            functionButton(icon: "chart.bar.fill", title: "排行榜")
            NavigationLink(destination: RidingHistoryView()) {
                functionButtonContent(icon: "location.fill", title: "历史轨迹", isSelected: false)
            }
            functionButton(icon: "chart.line.uptrend.xyaxis", title: "骑行分析")
        }
    }
    
    private func functionButton(icon: String, title: String) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedButton = selectedButton == title ? nil : title
            }
        }) {
            functionButtonContent(icon: icon, title: title, isSelected: selectedButton == title)
        }
    }
    
    private func functionButtonContent(icon: String, title: String, isSelected: Bool) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? .white : primaryPurple)
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(isSelected ? .white : .black)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 64)
        .padding(.vertical, 8)
        .background(
            isSelected ? primaryPurple : Color.white
        )
        .cornerRadius(6)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Total Distance Card
    private var totalDistanceCard: some View {
        VStack(spacing: 8) {
            Text("15596.6km")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("总里程数")
                .font(.system(size: 12))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Monthly Statistics
    private var monthlyStatistics: some View {
        VStack(alignment: .leading, spacing: 16) {
            monthHeader
            monthlyChart
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var monthHeader: some View {
        HStack {
            Button(action: {
                withAnimation {
                    // 这里可以添加切换月份的逻辑
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
            }
            
            Spacer()
            
            Text(selectedMonth)
                .font(.system(size: 16, weight: .bold))
            
            Spacer()
            
            // 为了保持对称
            Color.clear.frame(width: 24, height: 24)
        }
    }
    
    private var monthlyChart: some View {
        Chart(dailyData) { data in
            BarMark(
                x: .value("Day", data.day),
                y: .value("Distance", data.distance)
            )
            .foregroundStyle(
                data.day == "今日" ?
                    AnyShapeStyle(
                        LinearGradient(
                            colors: [gradientStart, gradientEnd],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    ) :
                    AnyShapeStyle(lightPurple)
            )
            .annotation(position: .top) {
                if data.day == "今日" {
                    todayAnnotation(distance: data.distance)
                }
            }
        }
        .frame(height: 200)
        .chartXAxis {
            AxisMarks(values: .automatic) { _ in
                AxisValueLabel()
                    .font(.system(size: 12))
                    .foregroundStyle(Color.gray)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisValueLabel {
                    if let distance = value.as(Double.self) {
                        Text("\(Int(distance))km")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.gray)
                    }
                }
            }
        }
    }
    
    private func todayAnnotation(distance: Double) -> some View {
        Text("\(distance, specifier: "%.1f") km")
            .font(.system(size: 10))
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(gradientStart)
            .cornerRadius(4)
    }
    
    // MARK: - Today's Data Card
    private var todayDataCard: some View {
        VStack(spacing: 12) {
            Text("当日数据")
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 0) {
                dataItem(value: "12.6km", title: "总里程数")
                Divider().frame(height: 40)
                dataItem(value: "21min", title: "时长")
                Divider().frame(height: 40)
                dataItem(value: "88km/h", title: "最高速度")
            }
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private func dataItem(value: String, title: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Data Models
struct DailyRiding: Identifiable {
    let id = UUID()
    let day: String
    let distance: Double
}

// MARK: - Preview
struct RidingView_Previews: PreviewProvider {
    static var previews: some View {
        RidingView()
    }
} 