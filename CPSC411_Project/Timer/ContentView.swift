import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var goal: String = ""
    @State private var isSignedIn: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to MindMentor!")
                    .padding(10)
                    .font(.custom("AppleSDGothicNeo-Bold", size: 26))
                    .border(Color.black)
                    .cornerRadius(2)
                    .background(Color.white)
                    .padding(80)
                Text("Please sign up below")
                TextField("Name", text: $name)
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                TextField("Goal", text: $goal)
                    .padding()

                NavigationLink(destination: MainView(name: name, username: username, goal: goal), isActive: $isSignedIn) {
                    TimerView()
                }
                .hidden()

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
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct MainView: View {
    var name: String
    var username: String
    var goal: String

    var body: some View {
        NavigationView {
           TimerView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
