import SwiftUI

struct ProfileStrengthCard: View {
    
    var strength: Double = 0.65 // 65% profile strength
    
    var body: some View {

        VStack(spacing: 0) {
            // Top section
            HStack {
                
                Image("today_workout")
                    .resizable()
                    .frame(width: 19, height: 19)
                
                Text("Strength Profile")
                    .font(.custom("Figtree", size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color(red: 1.0, green: 0.52, blue: 0.0))
                    .tracking(0)
                    .lineSpacing(10 * 0.10)
                    .frame(minWidth: 27, minHeight: 11, alignment: .leading)
                
                Spacer()
                
                // Arrow
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            Spacer()
            
            // Progress bars visualizer
            HStack(alignment: .bottom, spacing: 3) {
                ForEach(0..<44, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(
                            index < Int(44 * strength)
                            ? LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 1, green: 0.333, blue: 0),
                                    Color(red: 1, green: 0.576, blue: 0.365)
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            : LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.2)
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .frame(width: 4, height: 28)
                }
                
                VStack {
                    
                    Text("\(Int(strength * 100))%")
                        .font(.custom("Geist Mono", size: 22))
                        .fontWeight(.medium)
                        .foregroundColor(Color.white.opacity(0.95))
                        .multilineTextAlignment(.center)
                        .tracking(-0.66)
                        .lineSpacing(22 * 0.1)
                    
                    Text("achieved")
                        .font(.custom("Figtree", size: 9))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .lineSpacing(9 * 0.1)
                }
                .padding(.leading, 4)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
        .background(
            ZStack(alignment: .topLeading) {
                
                // Card background color
                Color(.sRGB, red: 0.114, green: 0.114, blue: 0.114, opacity: 0.75)

                // Light yellow gradient overlay on top left
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.81, green: 0.27, blue: 0.01).opacity(0.15),
                        Color.clear
                    ]),
                    center: .topLeading,
                    startRadius: 2,
                    endRadius: 110
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
}
