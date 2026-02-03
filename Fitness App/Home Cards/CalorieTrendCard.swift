import SwiftUI
import Charts

struct CalorieTrendCard: View {
    
    let data: [CalorieDataPoint1] = [
        CalorieDataPoint1(day: "Mon", calories: 1800),
        CalorieDataPoint1(day: "Tue", calories: 2100),
        CalorieDataPoint1(day: "Wed", calories: 2500),
        CalorieDataPoint1(day: "Thu", calories: 1950),
        CalorieDataPoint1(day: "Fri", calories: 2200),
        CalorieDataPoint1(day: "Sat", calories: 2400),
        CalorieDataPoint1(day: "Sun", calories: 2000)
    ]
    
    @State private var selectedDay: String?
    @State private var selectedCalories: Int?
    @State private var selectedX: CGFloat = .zero
    
    
    var body: some View {
        
        
        GeometryReader { geo in
            
            ZStack(alignment: .topLeading) {
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    // Header
                    HStack(spacing: 10) {
                        
                        Image("calories_trend")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("Calorie Trend")
                            .font(.custom("Figtree-SemiBold", size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0))
                            .tracking(0)
                            .lineSpacing(14 * 0.10)
                            .frame(minWidth: 81, minHeight: 15, alignment: .leading)
                        
                        Spacer()
                    }
                    
                    chart
                }
                .padding(16)
                
                // Floating tooltip
                if let day = selectedDay,
                   let calories = selectedCalories {
                    tooltip(day: day, calories: calories)
                        .position(
                            x: min(max(selectedX, 60), geo.size.width - 60),
                            y: 24
                        )
                }
            }
            .background(
                ZStack(alignment: .topLeading) {
                    
                    // card background color
                    Color(.sRGB, red: 0.114, green: 0.114, blue: 0.114, opacity: 0.75)

                    // Light yellow gradient overlay on top left
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.2, green: 0.84, blue: 0.29).opacity(0.08),
                            Color.clear
                        ]),
                        center: .topLeading,
                        startRadius: 20,
                        endRadius: 105
                    )
                }
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color(.sRGB, red: 40/255, green: 40/255, blue: 40/255, opacity: 1),
                        lineWidth: 1
                    )
            )
        }
    }
    
    private var chart: some View {
        Chart {
            ForEach(data, id: \.day) { point in
                LineMark(
                    x: .value("Day", point.day),
                    y: .value("Calories", point.calories)
                )
                .foregroundStyle(Color(hex: "#00A5F5"))
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [3, 3]))
                
                if selectedDay == point.day {
                    PointMark(
                        x: .value("Day", point.day),
                        y: .value("Calories", point.calories)
                    )
                    .foregroundStyle(Color(hex: "#00A5F5"))
                    .symbolSize(70)
                }
            }
        }
        .frame(height: 160)
        .chartYScale(domain: 1000...3000)
        .chartPlotStyle { plotArea in
            plotArea.padding(.leading, 0)
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [1000, 1500, 2000, 2500, 3000]) { value in
                if let v = value.as(Int.self) {
                    AxisValueLabel {
                        Text("\(v / 1000).\(v % 1000 / 100)k")
                            .font(.custom("Figtree", size: 10))
                            .foregroundColor(Color.white.opacity(0.75))
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: data.map(\.day)) { value in
                if let day = value.as(String.self) {
                    AxisValueLabel {
                        Text(day)
                            .font(.custom("Figtree", size: 11))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let locationX = value.location.x
                                
                                if let day: String = proxy.value(atX: locationX),
                                   let index = data.firstIndex(where: { $0.day == day }) {
                                    
                                    selectedDay = day
                                    selectedCalories = data[index].calories
                                    selectedX = locationX
                                }
                            }
                            .onEnded { _ in
                                withAnimation(.easeOut(duration: 0.2)) {
                                    selectedDay = nil
                                    selectedCalories = nil
                                }
                            }
                    )
            }
        }
    }
    
    private func tooltip(day: String, calories: Int) -> some View {
        
        VStack(spacing: 4) {
            Text("\(calories) kcal")
                .font(.custom("Figtree", size: 10))
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.0, green: 0.84, blue: 1.0))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .shadow(radius: 12)
    }
    
    
    
    private var verticalGridLines: some View {
        GeometryReader { geo in
            let count = data.count
            
            HStack(spacing: 0) {
                ForEach(0..<count, id: \.self) { _ in
                    Rectangle()
                        .fill(Color(hex: "#6BA2E4").opacity(0.05))
                        .frame(width: 1)
                    Spacer()
                }
            }
            .padding(.horizontal, 12)
        }
    }
    
    
    private var xAxisLabels: some View {
        HStack(spacing: 0) {
            ForEach(data, id: \.day) { point in
                Text(point.day)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.white.opacity(0.75))
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 12)
    }
}




struct CalorieDataPoint1 {
    let day: String
    let calories: Int
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xff) / 255
        let g = Double((int >> 8) & 0xff) / 255
        let b = Double(int & 0xff) / 255
        self.init(red: r, green: g, blue: b)
    }
}

