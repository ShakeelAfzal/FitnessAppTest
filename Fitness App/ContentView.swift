//
//  ContentView.swift
//  Fitness App
//
//  Created by admin on 1/28/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            Text("Workout Screen")
                .frame(maxWidth: .infinity, maxHeight: .infinity) // make it fill the screen
                .background(Color.black) // set background to black
                .foregroundColor(.white)
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Workout")
                }
                .tag(1)
            
            Text("Plan Screen")
                .frame(maxWidth: .infinity, maxHeight: .infinity) // make it fill the screen
                .background(Color.black) // set background to black
                .foregroundColor(.white)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Plan")
                }
                .tag(2)
            
            Text("Calories Screen")
                .frame(maxWidth: .infinity, maxHeight: .infinity) // make it fill the screen
                .background(Color.black) // set background to black
                .foregroundColor(.white)
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Calories")
                }
                .tag(3)
            
            ProfileView()
                .frame(maxWidth: .infinity, maxHeight: .infinity) // make it fill the screen
                .background(Color.black) // set background to black
                .foregroundColor(.white)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
//        .accentColor(Color(.sRGB, red: 226/255, green: 146/255, blue: 42/255, opacity: 1)) // optional: active tab color
        .accentColor(Color(red: 1.0, green: 0.58, blue: 0.0))
    }
}

#Preview {
    ContentView()
}
