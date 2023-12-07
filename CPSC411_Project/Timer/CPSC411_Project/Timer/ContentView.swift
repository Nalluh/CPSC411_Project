import SwiftUI

struct ContentView: View {
    @AppStorage("nightMode") var nightMode = false
    @State  var name: String = ""
    @State  var goal: String = ""
    @State  var isSignedIn: Bool = false
    @State  var isFormValid: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to StudyBuddy!")
                    .padding(10)
                    .font(.custom("AppleSDGothicNeo-Bold", size: 26))
                    .border(nightMode ? Color.white : Color.black)
                    .cornerRadius(2)
                    .background(nightMode ? Color.black : Color.white)
                    .padding(80)
                Text("Please fill infomation below:")
                InputFieldView(data: $name, title: "Name")
                    .onChange(of: name) { newValue in
                            validateForm()
                    }
                    .padding()
                InputFieldView(data: $goal, title: "Goal")
                    .onChange(of: goal) { newValue in
                            validateForm()
                    }
                    .padding()
                
                
                
                Button(action: {
                    // Additional logic can be added here to validate data before navigating
                    isSignedIn = true
                }) { // Submit Button will stay gray until credentials are filled and change color to blue
                    Text("Submit")
                        .padding(12)
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .background(isFormValid ? LinearGradient(gradient: Gradient(colors: [Color.teal, Color.blue]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .foregroundColor(Color.white)
                        .cornerRadius(35)
                }
                .disabled(!isFormValid)
                .padding(12)
                .navigationDestination(
                    isPresented:  $isSignedIn) {
                        MenuOptions(name: $name, goal: $goal)
                        Text("")
                            .hidden()
                    }
            }
            .preferredColorScheme(nightMode ? .dark : .light)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        nightMode.toggle()
                    }) {
                        Image(systemName: nightMode ? "moon.stars.fill" : "sun.max.fill")
                            .imageScale(.large)
                    }
                }
            }
            .padding()
            
        }
    }
    
    func validateForm() {
        isFormValid = !name.isEmpty && !goal.isEmpty
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
