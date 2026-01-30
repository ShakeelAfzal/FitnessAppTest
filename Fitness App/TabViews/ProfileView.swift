import SwiftUI

struct ProfileView: View {
    
    @AppStorage("calGoal") private var calGoal: String = "100"
    @AppStorage("currentCal") private var currentCal: String = "92"
    
    @AppStorage("carbsGoal") private var carbsGoal: String = "270"
    @AppStorage("currentCarbs") private var currentCarbs: String = "135"
    
    @AppStorage("proteinGoal") private var proteinGoal: String = "140"
    @AppStorage("currentprotein") private var currentprotein: String = "76"
    
    @AppStorage("fatsGoal") private var fatsGoal: String = "30"
    @AppStorage("currentFats") private var currentFats: String = "13"
    
    
    
    var body: some View {
        
        ScrollView {
            
            // MARK: - Set goal for calories
            VStack {
                
                Text("Calories")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Goal Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Goal")
                        .font(.headline)
                    
                    TextField("Enter goal", text: self.$calGoal)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: calGoal) { oldValue, newValue in
                            self.calGoal = newValue.filter { $0.isNumber }
                        }
                }
                
                // Current Value Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Value")
                        .font(.headline)
                    
                    TextField("Enter current value", text: self.$currentCal)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: currentCal) { oldValue, newValue in
                            
                            let filtered = newValue.filter { $0.isNumber }
                            
                            // Check if current exceeds goal
                            if let current = Int(filtered), current > self.getNumber(value: calGoal) {
                                currentCal = String(self.getNumber(value: calGoal))
                            } else {
                                currentCal = filtered
                            }
                        }
                }
            }
            
            Divider()
                .foregroundStyle(.gray)
            
            
            // MARK: - Set goal for Carbs
            VStack {
                
                Text("Carbs")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Goal Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Goal")
                        .font(.headline)
                    
                    TextField("Enter goal", text: self.$carbsGoal)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: carbsGoal) { oldValue, newValue in
                            carbsGoal = newValue.filter { $0.isNumber }
                        }
                }
                
                // Current Value Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Value")
                        .font(.headline)
                    
                    TextField("Enter current value", text: self.$currentCarbs)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: carbsGoal) { oldValue, newValue in
                            
                            let filtered = newValue.filter { $0.isNumber }
                            
                            // Check if current exceeds goal
                            if let current = Int(filtered), current > self.getNumber(value: carbsGoal) {
                                currentCarbs = String(self.getNumber(value: carbsGoal))
                            } else {
                                currentCarbs = filtered
                            }
                        }
                }
            }
            
            
            // MARK: - Set goal for Protein
            VStack {
                
                Text("Protein")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Goal Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Goal")
                        .font(.headline)
                    
                    TextField("Enter goal", text: self.$proteinGoal)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: proteinGoal) { oldValue, newValue in
                            proteinGoal = newValue.filter { $0.isNumber }
                        }
                }
                
                // Current Value Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Value")
                        .font(.headline)
                    
                    TextField("Enter current value", text: self.$currentprotein)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: proteinGoal) { oldValue, newValue in
                            
                            let filtered = newValue.filter { $0.isNumber }
                            
                            // Check if current exceeds goal
                            if let current = Int(filtered), current > self.getNumber(value: proteinGoal) {
                                currentprotein = String(self.getNumber(value: proteinGoal))
                            } else {
                                currentprotein = filtered
                            }
                        }
                }
            }
            
            Divider()
                .foregroundStyle(.gray)
            
            // MARK: - Set goal for Fats
            VStack {
                
                Text("Fats")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Goal Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Goal")
                        .font(.headline)
                    
                    TextField("Enter goal", text: self.$fatsGoal)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: fatsGoal) { oldValue, newValue in
                            fatsGoal = newValue.filter { $0.isNumber }
                        }
                }
                
                // Current Value Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Value")
                        .font(.headline)
                    
                    TextField("Enter current value", text: self.$currentFats)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .onChange(of: fatsGoal) { oldValue, newValue in
                            
                            let filtered = newValue.filter { $0.isNumber }
                            
                            // Check if current exceeds goal
                            if let current = Int(filtered), current > self.getNumber(value: fatsGoal) {
                                currentFats = String(self.getNumber(value: fatsGoal))
                            } else {
                                currentFats = filtered
                            }
                        }
                }
            }
            
            Spacer()
                .foregroundStyle(.gray)
        }
        .padding()
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    func getNumber(value: String) -> Int {
        return Int(value) ?? 0
    }
}


#Preview {
    ProfileView()
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
