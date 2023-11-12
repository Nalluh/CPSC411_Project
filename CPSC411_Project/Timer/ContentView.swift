import SwiftUI

struct ContentView: View {
    @State private var duration: String = ""
    @State private var goal: String = ""
    @State private var isSignedIn: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to StudyBuddy!")
                    .padding(10)
                    .font(.custom("AppleSDGothicNeo-Bold", size: 26))
                    .border(Color.black)
                    .cornerRadius(2)
                    .background(Color.white)
                    .padding(80)
                Text("Please fill timer specifications below")
                TextField("Duration", text: $duration)
                    .padding()
                TextField("Goal", text: $goal)
                    .padding()

            

                Button(action: {
                    // Additional logic can be added here to validate data before navigating
                    isSignedIn = true
                }) {
                    Text("Submit")
                        .padding(12)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                }
                .padding(12)
                NavigationLink(destination:  TimerView(duration: duration, goal: goal), isActive: $isSignedIn) {
                   
                }
                .hidden()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
