import SwiftUI

struct LastWeightCard: View {
    
    @State var value: String = ""
    @State var goal: String = ""
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            HStack(spacing: 4) {
                
                Image("last_weight")
                    .resizable()
                    .frame(width: 19, height: 19)
                
                Text("Last Weight")
                    .font(.custom("Figtree", size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .tracking(0)
                    .lineSpacing(10 * 0.10)
                    .frame(minWidth: 27, minHeight: 11, alignment: .leading)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 10))
                    .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
            }
            .padding(.horizontal, 8)
            
            HStack(alignment: .bottom) {
                Text("\(value)kg")
                    .font(.custom("GeistMono-Medium", size: 28))
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.95))
                    .tracking(-22 * 0.03)
                    .lineSpacing(22 * 0.10)
                
                Text("/\(goal)kg")
                    .font(.custom("GeistMono-Medium", size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.5))
                    .tracking(-14 * 0.03)
                    .lineSpacing(14 * 0.10)
                
            }
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
            self.value = "76"
            self.goal = "72"
        }
    }
}
