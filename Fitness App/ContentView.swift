
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.11, blue: 0.12)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HeaderView()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        // Daily Calorie Tracker
                        DailyCalorieTrackerCard()
                        
                        // Meal Macros
                        MealMacrosCard()
                        
                        // Workout Intensity
                        WorkoutIntensityCard()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text("👋")
                        .font(.system(size: 20))
                    Text("Welcome back ,")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                Text("Dhruv")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Streak Badge
            HStack(spacing: 4) {
                Text("🔥")
                    .font(.system(size: 16))
                Text("51")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(red: 0.15, green: 0.15, blue: 0.16))
            .cornerRadius(20)
        }
    }
}

#Preview {
    ContentView()
}
