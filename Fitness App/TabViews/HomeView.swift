

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HomeHeaderView()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        
                        // Daily Calorie Tracker
                        DailyCalorieTrackerCard()
                        
                        // Meal Macros
                        MealMacrosCard()
                        
                        // Workout Intensity
                        WorkoutIntensityCard()
                        
                        // Calories Trend
                        CalorieTrendCard()
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 250)
                }
            }
        }
    }
}

struct HomeHeaderView: View {
    var body: some View {
        HStack(spacing: 4) {
            
            Image("greeting")
                .resizable()
                .frame(width: 26, height: 26)
            
            VStack (spacing: 0) {
                Text("Welcome back ,")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.bottom, -4)
                
                Text("Dhruv")
                    .font(.custom("Anton-Regular", size: 28))
                    .fontWeight(.regular)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.9))
                    .tracking(0)
                    .lineSpacing(28 * 0.10)
                    .frame(minWidth: 94, minHeight: 31, alignment: .leading)
            }
            
            Spacer()
            
            // Streak Badge
            HStack(spacing: 4) {
                
                Image("flame")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text("51")
                    .font(.custom("Anton-Regular", size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.9))
                    .tracking(0)
                    .lineSpacing(28 * 0.10)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(red: 0.15, green: 0.15, blue: 0.16))
            .cornerRadius(20)
        }
    }
}

#Preview {
    HomeView()
}
