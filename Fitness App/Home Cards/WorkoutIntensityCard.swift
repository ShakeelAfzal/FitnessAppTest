import SwiftUI

struct WorkoutIntensityCard: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // Card Header
            HStack {
                HStack(spacing: 8) {
                    
                    Image("workout")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Workout Intensity")
                        .font(.custom("Figtree-SemiBold", size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0))
                        .tracking(0)
                        .lineSpacing(14 * 0.10)
                        .frame(minWidth: 81, minHeight: 15, alignment: .leading)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 10))
                    .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 16)
            
            Text("Last 8 weeks")
                .font(.custom("Figtree", size: 10))
                .fontWeight(.regular)
                .foregroundColor(Color.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)
            
            // Heatmap Grid
            GeometryReader { geometry in
                let totalSpacing: CGFloat = 4 * 7 // 4px spacing between 8 blocks = 7 gaps
                let availableWidth = geometry.size.width - 40 // subtract horizontal padding
                let blockWidth = (availableWidth - totalSpacing) / 8 // divide by number of columns
                
                VStack(spacing: 4) {
                    ForEach(0..<7) { row in
                        HStack(spacing: 4) {
                            ForEach(0..<8) { col in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(intensityColor(row: row, col: col))
                                    .frame(width: blockWidth, height: blockWidth / 2.4)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 7 * 13 + 6 * 4) // 7 rows of 13px height + 6 gaps of 4px
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            
            // Legend
            HStack(spacing: 8) {
                Text("Low")
                    .font(.custom("Figtree", size: 10))
                    .fontWeight(.regular)
                    .foregroundColor(Color.white.opacity(0.5))
                
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.white)
                        .frame(width: 12, height: 7)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.7, green: 0.9, blue: 1.0))
                        .frame(width: 12, height: 7)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.31, green: 0.78, blue: 1.0))
                        .frame(width: 12, height: 7)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.16, green: 0.51, blue: 1.0))
                        .frame(width: 12, height: 7)
                }
                
                Text("High")
                    .font(.custom("Figtree", size: 10))
                    .fontWeight(.regular)
                    .foregroundColor(Color.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
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
    
    // Helper function to determine intensity color based on position
    private func intensityColor(row: Int, col: Int) -> Color {
        // This simulates the pattern from the Figma SVG
        // Replace with your actual workout data
        let patterns: [[Int]] = [
            [1, 0, 2, 0, 0, 2, 0, 0],
            [1, 0, 2, 3, 3, 0, 2, 3],
            [1, 3, 3, 3, 3, 0, 0, 0],
            [1, 2, 3, 3, 1, 4, 3, 0],
            [1, 2, 1, 4, 3, 2, 3, 2],
            [1, 1, 2, 3, 2, 4, 3, 4],
            [1, 1, 3, 3, 3, 3, 4, 4]
        ]
        
        let intensity = patterns[row][col]
        
        switch intensity {
        case 0:
            return Color(red: 0.85, green: 0.85, blue: 0.86) // Gray (no workout)
        case 1:
            return .white // Very low
        case 2:
            return Color(red: 0.7, green: 0.9, blue: 1.0) // Light blue
        case 3:
            return Color(red: 0.31, green: 0.78, blue: 1.0) // Medium blue
        case 4:
            return Color(red: 0.16, green: 0.51, blue: 1.0) // Dark blue (high intensity)
        default:
            return .gray
        }
    }
}

// Preview
struct WorkoutIntensityCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            WorkoutIntensityCard()
                .frame(width: 356)
        }
    }
}
