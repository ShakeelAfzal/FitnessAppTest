import SwiftUI

struct DailyCalorieTrackerCard: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // Card Header
            HStack {
                HStack(spacing: 8) {
                    Text("🔥")
                        .font(.system(size: 16))
                    Text("Daily Calorie Tracker")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
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
                SpeedometerView(progress: 0.42) // 1050/2500 progress
                
                // Center text
                VStack(spacing: 4) {
                    Text("1250")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    Text("kcal to go")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 50)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .padding(.top, 90)
            
            // Stats
            HStack(spacing: 0) {
                StatView(icon: "🔥", label: "Calorie Intake", value: "1750kcal", color: Color(red: 1.0, green: 0.58, blue: 0.0))
                
                Divider()
                    .background(Color(red: 0.2, green: 0.2, blue: 0.21))
                    .frame(height: 40)
                
                StatView(icon: "🔥", label: "Calorie Burned", value: "250kcal", color: Color(red: 1.0, green: 0.58, blue: 0.0))
                
                Divider()
                    .background(Color(red: 0.2, green: 0.2, blue: 0.21))
                    .frame(height: 40)
                
                StatView(icon: "🔥", label: "Calorie Goal", value: "2500kcal", color: Color(red: 1.0, green: 0.58, blue: 0.0))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(
            ZStack(alignment: .topLeading) {
                Color(red: 0.15, green: 0.15, blue: 0.16)
                
                // Light yellow gradient overlay on top left
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.95, blue: 0.7).opacity(0.15),
                        Color.clear
                    ]),
                    center: .topLeading,
                    startRadius: 20,
                    endRadius: 200
                )
            }
        )
        .cornerRadius(20)
    }
}

struct StatView: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 4) {
                
                Circle()
                    .fill(self.getStatColor())
                    .frame(width: 8, height: 8)
                
                
                VStack (alignment: .leading) {
                    Text(label)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    
                    Text(value)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
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
