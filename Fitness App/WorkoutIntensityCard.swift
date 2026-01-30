import SwiftUI

struct WorkoutIntensityCard: View {
    // Sample data for last 8 weeks
    let weekData: [Double] = [0.6, 0.3, 0.5, 0.8, 0.4, 0.7, 0.5, 0.6]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Card Header
            HStack {
                HStack(spacing: 8) {
                    
                    Image("workout")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Workout Intensity")
                        .font(.custom("Figtree", size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0))
                        .tracking(0)
                        .lineSpacing(14 * 0.10)
                        .frame(minWidth: 115, minHeight: 15, alignment: .leading)
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
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.16))
        .cornerRadius(20)
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
