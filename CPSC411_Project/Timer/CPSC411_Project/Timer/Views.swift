//
//  onboard.swift
//  Timer
//
//  Created by Allan Cortes on 11/11/23.
//
import SwiftUI

struct FlashCard {
    var title: String
    var description: String
}

class FlashCardData: ObservableObject {
    @Published var flashcards: [String] = []
    @Published var flashcardsInfo: [String:String] = [:]
    @Published var flashView: [String : [String:String]] = [:]
    
}

//not used for now
struct OnboardingView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var goal = ""
 
    var body: some View {
        VStack {
            Text("Welcome to MindMentor!")
                .padding(10)
                .font(.custom("AppleSDGothicNeo-Bold", size: 26))      .border(Color.black)
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
            Button(action:{
                print("test")
            }){
                Text("Submit")
            } .padding(12)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(15)
        }
        .padding()
      
    }
}
//not used for now

struct MenuOptions: View{
    @Binding var name: String
    @Binding var goal: String
    @State  var clickOnTimer: Bool = false
    @State  var clickOnFlashCard: Bool = false
    @State private var flashCardData: FlashCardData = FlashCardData()
    @State private var selectedTab = 0
    @AppStorage("nightMode") private var nightMode = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack{
                    Text("Welcome. \(name)")
                        .padding()
                        .font(.custom("AppleSDGothicNeo-Bold", size: 16))
                    Text("Dont forget the goal:")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 16))
                    Text(goal)
                        .padding(-1)
                        .font(.custom("AppleSDGothicNeo-Bold", size: 24))
                        .bold()
                    
                    //this block links to timer
                    Button(action: {
                        //when button is clicked variable is set to true
                        //which makes the condition on NavigationLink become true
                        //so the view switches
                        clickOnTimer = true
                    }) {
                        Text("Study Area")
                            .frame(width: 150, height: 20)
                            .padding(12)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    }
                    .padding(12)
                    NavigationLink(destination: TimerView(flashCardData: flashCardData), isActive: $clickOnTimer) {
                        
                    }.hidden()
                    // end timer block
                    
                    // This block is for flash cards
                    Button(action: {
                        
                        clickOnFlashCard = true
                    }) {
                        Text("Create Flashcards")
                            .frame(width: 150, height: 20)
                            .padding(12)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    }
                    .padding(12)
                    NavigationLink(destination: FlashCardView(flashCardData: flashCardData), isActive: $clickOnFlashCard) {
                        
                    }.hidden()
                    //end flash card block
                    
                    
                    
                    
                }.navigationBarBackButtonHidden(true)
                // if buttons looks ugly change this
                    .buttonStyle(.borderedProminent)
            }
            .tabItem {
                Label("Home", systemImage: "book.closed.fill")
            }
            .tag(0)
            
            SettingsView(nightMode: $nightMode, name: $name, goal: $goal)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(1)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
        
}

struct SettingsView: View {
    @Binding var nightMode: Bool
    @Binding var name: String
    @Binding var goal: String
    @State private var newName: String = ""
    @State private var newGoal: String = ""
    @State private var showUpdateSuccess: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Settings")
                    .font(.largeTitle)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                Toggle("Night Mode", isOn: $nightMode)
                    .padding()
                
                SettingsTextField(placeholder: "Change Name",
                    text: $newName, nightMode: nightMode)
                .padding()
                
                SettingsTextField(placeholder: "Change Goal",
                    text: $newGoal, nightMode: nightMode)
                    .padding()
                HStack {
                    Spacer()
                    Button("Update") {
                        if !newName.isEmpty {
                            self.name = self.newName
                            self.newName = ""
                            self.showUpdateSuccess = true
                        }
                        if !newGoal.isEmpty {
                            self.goal = self.newGoal
                            self.newGoal = ""
                            self.showUpdateSuccess = true
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showUpdateSuccess) {
                Alert(title: Text("Update Successful"), message: Text("Change has been made!"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct SettingsTextField: View {
    var placeholder: String
    @Binding var text: String
    var nightMode: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(nightMode ? Color.gray : Color.primary.opacity(0.5)) // Adjust the color and opacity
                    .padding(.horizontal, 12)
                    .frame(height: 42)
            }

            TextField("", text: $text)
                .foregroundColor(nightMode ? Color.primary : Color.primary) // Change the TextField text color
                .padding(.horizontal, 12)
                .frame(height: 42)
        }
        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.primary))
    }
}

//work on user submitting topic name then add flash card title and desc
struct FlashCardView: View {
    @State private var newFlashcardTitle: String = ""
    @State private var newFlashcardDesc: String = ""
    @State private var isCreatingNewFlashcard: Bool = false
    @State private var flashcards: [String] = []
    @ObservedObject var flashCardData: FlashCardData = FlashCardData()
    
 
    
    var body: some View {
            
      
     
        if( !isCreatingNewFlashcard && flashCardData.flashcards.isEmpty) {
                
                Section(header: Text("Flashcards")){
                    Spacer()
                    Button(action: {
                        isCreatingNewFlashcard.toggle()
                    }) {
                        Text("Add Collection")
                            .buttonStyle(.borderedProminent)
                    }
                }
                Spacer()
            }
            
        
        else {
            Section(header: Text("New Flashcard")){
                VStack{
                    TextField("Enter Flashcard Title", text: $newFlashcardTitle)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                
                Button(action: {
                    var newFlashcardTitle = self.newFlashcardTitle

                                flashCardData.flashcards.append(newFlashcardTitle)
                                flashCardData.flashView[newFlashcardTitle] = [:]

                    newFlashcardTitle = ""
                    }) {
                    Text("Submit")
                    .buttonStyle(.borderedProminent)
                        }
                    .padding()
                List {
                    ForEach(flashCardData.flashcards.indices, id: \.self) { index in
                    NavigationLink(destination: FlashCardDetailView(flashCardData: flashCardData, flashcardIndex: index)) {
                          Text(flashCardData.flashcards[index])
                                        }
                                    }
                                }
                                .padding()
                            }
                           // .navigationTitle("Flashcards")
            }
        }
    }



struct FlashCardDetailView: View {
    @ObservedObject var flashCardData: FlashCardData
    @State private var newQuestion: String = ""
    @State private var newAnswer: String = ""
    var flashcardIndex: Int

    var body: some View {
        VStack {
            Text("Flashcard Detail")
                .font(.title)

            Text("Title: \(flashCardData.flashcards[flashcardIndex])")
                .padding()

            TextField("Enter Flashcard Description", text: $flashCardData.flashcards[flashcardIndex])
                .textFieldStyle(.roundedBorder)
                .padding()

            if flashCardData.flashcards.count  != 0 {
                HStack {
                    Text("Question")
                    Spacer()
                    Text("Answer")
                }
                .font(.subheadline)
                .padding()
            }

            
              
           
                     if let cards = flashCardData.flashView[flashCardData.flashcards[flashcardIndex]] {
            
                             ForEach(cards.sorted(by: { $0.0 < $1.0 }), id: \.key) { key, value in
                                 HStack {
                                     Text(key)
                                     Spacer()
                                     Text(value)
                                 }
                             }
                         
                     }
                
            
        }.padding()

        VStack {
            HStack {
                TextField("Enter Question", text: $newQuestion)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                TextField("Enter Answer", text: $newAnswer)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button(action: {
                    flashCardData.flashView[flashCardData.flashcards[flashcardIndex]]?.updateValue(newAnswer, forKey: newQuestion)
                    
                    
                    print(flashCardData.flashView.count)
                        newQuestion = ""
                        newAnswer = ""
                }) {
                    Text("Add")
                        .buttonStyle(.borderedProminent)
                }
                .padding()
            }

            

            Spacer()
        }
        .padding()
    }
}





// add ability to allow user to view flash cards when start button is pressed
// pass flashcards to timer to view
struct TimerView: View {

    @StateObject private var vm = ViewModel()
    @ObservedObject var flashCardData: FlashCardData = FlashCardData()
    var viewFC:Bool = false
    //refreshes timer every 1 second
    // starts automatically
    private let  timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //for ui
    private let width: Double = 250
  
    @State private var clickOnX: Bool = false

    var body: some View {
        
            VStack{
                
                VStack{
                    //Sets default of 5 mins
                    // can be changed in timerfunctionality
                    
                    Text("\(vm.timer)")
                        .font(.system(size: 70, weight: .medium,design: .rounded))
                        .padding()
                        .frame(width:width)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth:4))
                    //Once the timer is done text will be displayed
                        .alert("Times up", isPresented: $vm.activeAlert){
                            // when user is prompted we can add some functionality
                            // to button
                            Button("Continue", role: .cancel){
                                //todo app does something when clicked
                            }
                        }
                    
                    // change value to something not zero
                    // zero is used for testing
                    Slider(value:$vm.mins, in: 0...60, step:1)
                        .padding()
                        .frame(width:width)
                        .disabled(vm.activeAlert)
                        .animation(.easeInOut, value: vm.mins)
                        .tint(.gray)
                    VStack{
                    HStack(spacing: 50){
                        //button to start timer
                          
                        Button("Start"){
                          
                            if(!flashCardData.flashcards.isEmpty && !vm.isRunning){
                                
                                clickOnX = true
                                vm.startTimer(mins: vm.mins)
                            }
                            else{
                                vm.startTimer(mins: vm.mins)

                            }
                        }.tint(.green)
                        .disabled(vm.activeAlert)
                        
                        //button to end timer
                        Button("Reset", action: vm.reset)
                            .tint(.red)
                    }.frame(width:width)
                            .padding()
                        if(vm.isRunning)
                        {
                            if(flashCardData.flashcards.count < 2){
                                Button("View Flashcard"){
                                    
                                    clickOnX = true
                                }
                            }
                           else{
                                Button("View Flashcards"){
                                
                                clickOnX = true
                            }
                        }
                        }
                }
                    NavigationLink(destination: Flashcards(flashCardData: flashCardData), isActive: $clickOnX) {
                                           
                                        }.hidden()
                }
                .onReceive(timer) { _ in
                    vm.updateTimer()
              
                
            }
        }//.navigationBarBackButtonHidden(true)
    }
}

struct InputFieldView: View {
    @AppStorage("nightMode") var nightMode = false
    @Binding var data: String
    var title: String?
    
    var body: some View {
        ZStack {
            TextField("", text: $data)
              .padding(.horizontal, 10)
              .frame(height: 42)
              .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                    .stroke(Color.teal, lineWidth: 1)
              )
            HStack {                    // HStack for the text
              Text(title ?? "Input")
                .font(.headline)
                .fontWeight(.thin)      // making the text small
                .foregroundColor(Color.mint)    // and teal
                .multilineTextAlignment(.leading)
                .padding(4)
                .background(nightMode ? Color.black : Color.white)     // adding some white background
              Spacer()                  // pushing the text to the left
            }
            .padding(.leading, 8)
            .offset(CGSize(width: 0, height: -20))  // pushign the text up to overlay the border of the input field
          }.padding(4)
    }
}
struct Flashcards: View {
    @State private var newFlashcardTitle: String = ""
    @State private var isCreatingNewFlashcard: Bool = false
    @State private var flashcards: [String] = []
    @ObservedObject var flashCardData: FlashCardData = FlashCardData()
    
 
    
    var body: some View {
            
        
                List {
                    ForEach(flashCardData.flashcards.indices, id: \.self) { index in
                    NavigationLink(destination: FlashCardDetailViewNoEdit(flashCardData: flashCardData, flashcardIndex: index)) {
                          Text(flashCardData.flashcards[index])
                                        }
                                    }
                                }
                                .padding()
                                .navigationTitle("Sets")
                            }
      
            }
        
struct FlashCardDetailViewNoEdit: View {
    @ObservedObject var flashCardData: FlashCardData
    var flashcardIndex: Int = 0
    @State private var flippedKeys: Set<String> = []
    var body: some View {
            if let cards = flashCardData.flashView[flashCardData.flashcards[flashcardIndex]] {
                Text(flashCardData.flashcards[flashcardIndex])
               
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(cards.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(flippedKeys.contains(key) ? value : key)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .rotation3DEffect(
                                        .degrees(flippedKeys.contains(key) ? 360 : 0),
                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                                    )
                                    .onTapGesture {
                                        withAnimation {
                                            if flippedKeys.contains(key) {
                                                flippedKeys.remove(key)
                                            } else {
                                                flippedKeys.insert(key)
                                            }
                                        }
                                    }
                            }
                            .frame(maxWidth: .infinity, alignment: .center) // Use .infinity for fixed width
                                .padding(30)
                                .background(
                                RoundedRectangle(cornerRadius: 10)
                               .stroke(Color.gray, lineWidth: 1)
                                )
                          
                            
                           
                        }
                        
                    }
                    .padding()
                }
            }
        Spacer()
        }
}

struct Previews_onboard_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
