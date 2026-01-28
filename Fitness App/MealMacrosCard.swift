import SwiftUI

struct MealMacrosCard: View {
    
    let totalCarbs = 270
    let totalProtein = 140
    let totalFats = 30
    
    
    // change these values to change the ring progress
    let currentCarbs = 230
    let currentProtein = 76
    let currentFats = 27
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            // Card Header
            HStack {
                HStack(spacing: 8) {
                    Text("🍎")
                        .font(.system(size: 16))
                    Text("Meal Macros")
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
            
            // Semi-circular macro visualization - concentric rings
            ZStack {
                // Fats (cyan) - innermost ring
                SemiCircleSegment(icon: "🔥", startAngle: 90, endAngle: self.getCarbsValue(), color: Color(red: 0.35, green: 0.78, blue: 0.98), radius: 50, thickness: 18)
                
                // Protein (green) - middle ring
                SemiCircleSegment(icon: "💪", startAngle: 90, endAngle: self.getProteinValue(), color: Color(red: 0.2, green: 0.84, blue: 0.29), radius: 75, thickness: 18)
                
                // Carbs (orange) - outermost ring
                SemiCircleSegment(icon: "🥑", startAngle: 90, endAngle: self.getFatsValue(), color: Color(red: 1.0, green: 0.58, blue: 0.0), radius: 100, thickness: 18)
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
            
            // Macro breakdown
//            HStack(spacing: 12) {
                
            // Macro breakdown
            HStack(spacing: 4) { // spacing between cards
                MacroStatCard(icon: "🔥", label: "Carbs", value: "135g", goal: "\(self.totalCarbs)g", color: Color(red: 1.0, green: 0.58, blue: 0.0))
                MacroStatCard(icon: "💪", label: "Protein", value: "76g", goal: "\(self.totalProtein)g", color: Color(red: 0.2, green: 0.84, blue: 0.29))
                MacroStatCard(icon: "🥑", label: "Fats", value: "13g", goal: "\(self.totalFats)g", color: Color(red: 0.35, green: 0.78, blue: 0.98))
            }
            .padding(4) // padding inside the HStack to show background
            .background(Color(red: 0.11, green: 0.11, blue: 0.12))
            .cornerRadius(16)
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
//        .background(Color(red: 0.15, green: 0.15, blue: 0.16))
        .background(
            ZStack(alignment: .topLeading) {
                Color(red: 0.15, green: 0.15, blue: 0.16)
                
                // Light yellow gradient overlay on top left
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.2, green: 0.84, blue: 0.29).opacity(0.15),
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
    
    private func getCarbsValue() -> Double {
        
        let dividend: Double = Double(self.currentCarbs) / Double(self.totalCarbs)
        let value = 180 * dividend
        return Double(value + 90)
    }
    
    private func getProteinValue() -> Double {
        
        let dividend: Double = Double(self.currentProtein) / Double(self.totalProtein)
        let value = 180 * dividend
        return Double(value + 90)
    }
    
    private func getFatsValue() -> Double {
        
        let dividend: Double = Double(self.currentFats) / Double(self.totalFats)
        let value = 180 * dividend
        return Double(value + 90)
    }
}

struct SemiCircleSegment: View {
    
    let icon: String
    let startAngle: Double
    let endAngle: Double
    let color: Color
    let radius: CGFloat
    let thickness: CGFloat
    
    var body: some View {
        ZStack {
            // Arc
            Circle()
                .trim(from: startAngle / 360, to: endAngle / 360)
                .stroke(color, style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                .frame(width: radius * 2, height: radius * 2)
                .rotationEffect(.degrees(90))
            
            Text(icon)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.white)
                .offset(iconOffset())
                .padding(.trailing, 18)
                .padding(.bottom, 4)
        }
    }
    
    private func iconOffset() -> CGSize {
        let angle = (startAngle + 90) * .pi / 180
        let adjustedRadius = Double(radius - thickness / 2)

        return CGSize(
            width: CGFloat(cos(angle) * adjustedRadius),
            height: CGFloat(sin(angle) * adjustedRadius)
        )
    }
}

struct MacroStatCard: View {
    let icon: String
    let label: String
    let value: String
    let goal: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Text(icon)
                    .font(.system(size: 12))
                Text(label)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            Text(goal)
                .font(.system(size: 11))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(red: 0.15, green: 0.15, blue: 0.16))
        .cornerRadius(12)
    }
}



#Preview {
    ZStack {
        Color(red: 0.11, green: 0.11, blue: 0.12)
            .ignoresSafeArea()
        MealMacrosCard()
            .padding()
    }
}
