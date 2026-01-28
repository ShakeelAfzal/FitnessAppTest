import SwiftUI

struct WorkoutIntensityCard: View {
    // Sample data for last 8 weeks
    let weekData: [Double] = [0.6, 0.3, 0.5, 0.8, 0.4, 0.7, 0.5, 0.6]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Card Header
            HStack {
                HStack(spacing: 8) {
                    Text("🏋️")
                        .font(.system(size: 16))
                    Text("Workout Intensity")
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
            .padding(.bottom, 16)
            
            // Last 8 weeks label
            Text("Last 8 weeks")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            
            // Bar chart
            HStack(alignment: .bottom, spacing: 16) {
                ForEach(0..<weekData.count, id: \.self) { index in
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(red: 0.2, green: 0.2, blue: 0.21))
                            .frame(width: 28, height: 60)
                            .overlay(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color(red: 0.2, green: 0.84, blue: 0.29), Color(red: 0.15, green: 0.65, blue: 0.22)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(height: 60 * weekData[index])
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
            
            // Bottom navigation dots
            HStack(spacing: 8) {
                TabIndicator(icon: "house.fill", label: "Home", isActive: true)
                TabIndicator(icon: "dumbbell.fill", label: "Workout", isActive: false)
                TabIndicator(icon: "chart.bar.fill", label: "Plan", isActive: false)
                TabIndicator(icon: "flame.fill", label: "Calories", isActive: false)
                TabIndicator(icon: "person.fill", label: "Profile", isActive: false)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.16))
        .cornerRadius(20)
    }
}

struct TabIndicator: View {
    let icon: String
    let label: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(isActive ? Color(red: 1.0, green: 0.58, blue: 0.0) : .gray)
            
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(isActive ? Color(red: 1.0, green: 0.58, blue: 0.0) : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color(red: 0.11, green: 0.11, blue: 0.12)
            .ignoresSafeArea()
        WorkoutIntensityCard()
            .padding()
    }
}
