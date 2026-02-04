import SwiftUI

struct MealMacrosCard: View {
    
    @AppStorage("carbsGoal") private var carbsGoal: String = "270"
    @AppStorage("currentCarbs") private var currentCarbs: String = "135"
    
    @AppStorage("proteinGoal") private var proteinGoal: String = "140"
    @AppStorage("currentprotein") private var currentprotein: String = "76"
    
    @AppStorage("fatsGoal") private var fatsGoal: String = "30"
    @AppStorage("currentFats") private var currentFats: String = "13"
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            // Card Header
            HStack {
                HStack(spacing: 8) {
                    
                    Image("meal")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Meal Macros")
                        .font(.custom("Figtree-SemiBold", size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0))
                        .tracking(0)
                        .lineSpacing(14 * 0.10)
                        .frame(minWidth: 81, minHeight: 15, alignment: .leading)
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
                SemiCircleSegment(icon: "fatWhite", startAngle: 90, endAngle: self.getFatsValue(), color: Color(red: 0.0, green: 0.65, blue: 0.96), radius: 50, thickness: 20)
                
                // Protein (green) - middle ring
                SemiCircleSegment(icon: "proteinWhite", startAngle: 90, endAngle: self.getProteinValue(), color: Color(red: 0.18, green: 0.83, blue: 0.43), radius: 75, thickness: 20)
                
                // Carbs (orange) - outermost ring
                SemiCircleSegment(icon: "carbWhite", startAngle: 90, endAngle: self.getCarbsValue(), color: Color(red: 1.0, green: 0.52, blue: 0.0), radius: 100, thickness: 20)
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
            
                
            // Macro breakdown
            HStack(spacing: 4) { // spacing between cards
                MacroStatCard(icon: "carb", label: "Carbs", value: "\(self.currentCarbs)g", goal: "\(self.carbsGoal)g", color: Color(red: 1.0, green: 0.58, blue: 0.0))
                MacroStatCard(icon: "protein", label: "Protein", value: "\(self.currentprotein)g", goal: "\(self.proteinGoal)g", color: Color(red: 0.2, green: 0.84, blue: 0.29))
                MacroStatCard(icon: "fat", label: "Fats", value: "\(self.currentFats)g", goal: "\(self.fatsGoal)g", color: Color(red: 0.35, green: 0.78, blue: 0.98))
            }
            .padding(4) // padding inside the HStack to show background
            .background(Color(red: 0.07, green: 0.07, blue: 0.07))
            .cornerRadius(16)
            .padding(.horizontal)
            .padding(.bottom, 20)
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
    
    private func getCarbsValue() -> Double {
        
        let dividend: Double = (Double(self.currentCarbs) ?? 0) / (Double(self.carbsGoal) ?? 0)
        let value = 180 * dividend
        return Double(value + 90)
    }
    
    private func getProteinValue() -> Double {
        
        let dividend: Double = (Double(self.currentprotein) ?? 0) / (Double(self.proteinGoal) ?? 0)
        let value = 180 * dividend
        return Double(value + 90)
    }
    
    private func getFatsValue() -> Double {
        
        let dividend: Double = (Double(self.currentFats) ?? 0) / (Double(self.fatsGoal) ?? 0)
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
            
            
            Circle()
                .trim(from: 90 / 360, to: 270 / 360) // For semi-circle (0 to 180 degrees)
                .stroke(color.opacity(0.2), style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                .frame(width: radius * 2, height: radius * 2)
                .rotationEffect(.degrees(90))
            
            // Arc
            Circle()
                .trim(from: startAngle / 360, to: endAngle / 360)
                .stroke(color, style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                .frame(width: radius * 2, height: radius * 2)
                .rotationEffect(.degrees(90))
                
            
            Image(icon)
                .resizable()
                .frame(width: 10, height: 10)
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
                
                Image(icon)
                    .resizable()
                    .frame(width: 10, height: 10)
                
                Text(label)
                    .font(.custom("Figtree", size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color(red: 1.0, green: 0.52, blue: 0.0))
                    .tracking(0)
                    .lineSpacing(10 * 0.10)
                    .frame(minWidth: 27, minHeight: 11, alignment: .leading)
                
                Spacer()
            }
            .padding(.leading, 8)
            
            HStack(alignment: .bottom) {
                Text(value)
                    .font(.custom("GeistMono-Medium", size: 22))
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.95))
                    .tracking(-22 * 0.03)
                    .lineSpacing(22 * 0.10)
                
                Text(goal)
                    .font(.custom("GeistMono-Medium", size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.5))
                    .tracking(-14 * 0.03)
                    .lineSpacing(14 * 0.10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(red: 0.15, green: 0.15, blue: 0.16))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    Color(red: 0.16, green: 0.16, blue: 0.16),
                    lineWidth: 1
                )
        )
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
