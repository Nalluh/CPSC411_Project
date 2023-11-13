import SwiftUI

struct ContentView: View {
    @State  var name: String = ""
    @State  var goal: String = ""
    @State  var isSignedIn: Bool = false

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
                Text("Please fill infomation below")
                TextField("Name", text: $name)
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
                NavigationLink(destination:  MenuOptions(name:name,goal:goal), isActive: $isSignedIn) {
                   
                }
                .hidden()
            }
            .padding()
         
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
