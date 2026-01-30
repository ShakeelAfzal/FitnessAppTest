import SwiftUI

struct DailyCalorieTrackerCard: View {
    
    @AppStorage("calGoal") private var calGoal: String = "100"
    @AppStorage("currentCal") private var currentCal: String = "92"
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // Card Header
            HStack {
                HStack(spacing: 8) {
                    
                    Image("calories")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Daily Calorie Tracker")
                                .font(.custom("Figtree-SemiBold", size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0))
                                .tracking(0)
                                .lineSpacing(14 * 0.10)
                                .frame(minWidth: 131, minHeight: 15, alignment: .leading)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 24)
            
            // Circular Progress with Speedometer Bars
            ZStack {
                // Speedometer bars
                SpeedometerView(progress: self.getProgress())
                
                // Center text
                VStack(spacing: 4) {
                    
                    Text(self.calGoal)
                        .font(.custom("GeistMono-Medium", size: 34.85))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.95))
                        .tracking(-34.85 * 0.03) // -3% letter spacing
                        .lineSpacing(34.85 * 0.10) // 110% line height
                        .multilineTextAlignment(.center)
                        .frame(width: 93.456, height: 38)
                    
                    Text("kcal to go")
                        .font(.custom("Figtree", size: 14.26))
                        .fontWeight(.regular)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.5))
                        .tracking(0) // 0% letter spacing
                        .lineSpacing(14.26 * 0.10) // 110% line height
                        .multilineTextAlignment(.center)
                        .frame(width: 93.456, height: 16)
                }
                .padding(.bottom, 50)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .padding(.top, 100)
            
            HStack(spacing: 20) {
                StatView(label: "Calorie Intake", value: "\(self.currentCal)kcal")
                
                StatView(label: "Calorie Burned", value: "\(Int(self.calGoal) ?? 0 - (Int(self.currentCal) ?? 0))kcal")
                
                StatView(label: "Calorie Goal", value: "\(self.calGoal)kcal")
            }
            .padding(.leading, 40)
            .padding(.bottom, 20)
        }
        .background(
            ZStack(alignment: .topLeading) {
                
                // Card background color
                Color(.sRGB, red: 0.114, green: 0.114, blue: 0.114, opacity: 0.75)

                // Light yellow gradient overlay on top left
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(.sRGB, red: 0.886, green: 0.573, blue: 0.165, opacity: 0.15),
                        Color.clear
                    ]),
                    center: .topLeading,
                    startRadius: 20,
                    endRadius: 115
                )
            }
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20) // match the same radius
                .stroke(
                    Color(.sRGB, red: 40/255, green: 40/255, blue: 40/255, opacity: 1),
                    lineWidth: 1
                )
        )
    }
    
    func getProgress() -> Double {
        return (Double(self.currentCal) ?? 0) / (Double(self.calGoal) ?? 0)
    }
}

struct StatView: View {
    
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment: .top, spacing: 4) {
                
                Circle()
                    .fill(self.getStatColor())
                    .frame(width: 8, height: 8)
                
                
                VStack (alignment: .leading) {
                    
                    Text(label)
                        .font(.custom("Figtree", size: 10))
                        .fontWeight(.regular)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.65))
                        .tracking(-10 * 0.02)
                        .lineSpacing(10 * 0.10)
//                        .frame(minWidth: 59, minHeight: 11, alignment: .leading)
                    
                    Text(value)
                        .font(.custom("GeistMono-Medium", size: 13))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.95))
                        .tracking(-13 * 0.03)
                        .lineSpacing(13 * 0.10)
                        .multilineTextAlignment(.trailing)
//                        .frame(width: 70, height: 14, alignment: .trailing)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func getStatColor() -> Color {
        
        if self.label.contains("Intake") {
            return Color.yellow
        }
        else if self.label.contains("Burned") {
            return Color.orange
        }
        else if self.label.contains("Goal") {
            return Color.red
        }
        else {
            return Color.yellow
        }
    }
}

struct SpeedometerView: View {
    let progress: Double // 0.0 to 1.0
    let totalBars = 50 // Number of bars in the speedometer
    let barWidth: CGFloat = 4
    let barHeight: CGFloat = 16
    let radius: CGFloat = 120
    
    var body: some View {
        ZStack {
            ForEach(0..<totalBars, id: \.self) { index in
                // Start from 180 degrees (left) and span 180 degrees to make half circle
                let angle = 270.0 + (Double(index) / Double(totalBars - 1)) * 180.0
                let isActive = Double(index) / Double(totalBars - 1) <= progress
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(isActive ?
                          Color(red: 1.0, green: 0.58, blue: 0.0) :
                          Color(red: 0.2, green: 0.2, blue: 0.21))
                    .frame(width: barWidth, height: barHeight + 3)
                    .offset(y: -radius)
                    .rotationEffect(.degrees(angle))
            }
        }
        .frame(width: radius * 2, height: radius * 2)
    }
}

#Preview {
    ZStack {
        Color(red: 0.11, green: 0.11, blue: 0.12)
            .ignoresSafeArea()
        DailyCalorieTrackerCard()
            .padding()
    }
}
