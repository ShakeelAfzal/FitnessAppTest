import SwiftUI

struct TodayWorkoutCard: View {
    
    @State var workoutName: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack(spacing: 4) {
                
                Image("today_workout")
                    .resizable()
                    .frame(width: 19, height: 19)
                
                Text("Today’s workout")
                    .font(.custom("Figtree", size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .tracking(0)
                    .lineSpacing(10 * 0.10)
                    .frame(minWidth: 27, minHeight: 11, alignment: .leading)
                
                Spacer()
            }
            .padding(.leading, 8)
            
            
            Text(self.workoutName)
                .font(.custom("Anton-Regular", size: 32))
                .fontWeight(.regular)
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.75))
                .tracking(0)
                .lineSpacing(28 * 0.10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .padding(.vertical, 16)
        .background(Color(.sRGB, red: 0.114, green: 0.114, blue: 0.114, opacity: 0.75))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    Color(red: 0.16, green: 0.16, blue: 0.16),
                    lineWidth: 1
                )
        )
        .onAppear {
            self.workoutName = "CHEST"
        }
    }
}
