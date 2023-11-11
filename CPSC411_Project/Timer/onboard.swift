//
//  onboard.swift
//  Timer
//
//  Created by Allan Cortes on 11/11/23.
//
import SwiftUI

import SwiftUI

struct OnboardingView: View {
    // Add your properties for user input here (e.g., @State variables for name, username, goal)
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

struct TimerView: View{
    @StateObject private var vm = ViewModel()
    //refreshes timer every 1 second
    // starts automatically
    private let  timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //for ui
    private let width: Double = 250
    var body: some View {
        NavigationView {
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
                    .alert("TIMER DONE", isPresented: $vm.activeAlert){
                        // when user is prompted we can add some functionality
                        // to button
                        Button("Continue", role: .cancel){
                            //todo app does something when clicked
                        }
                    }
                
                // change value to something not zero
                // zero is used for testing
                Slider(value:$vm.mins, in: 0...10, step:1)
                    .padding()
                    .frame(width:width)
                    .disabled(vm.activeAlert)
                    .animation(.easeInOut, value: vm.mins)
                
                HStack(spacing: 50){
                    //button to start timer
                    Button("Start"){
                        vm.startTimer(mins: vm.mins)
                    }
                    .disabled(vm.activeAlert)
                    
                    //button to end timer
                    Button("Reset", action: vm.reset)
                        .tint(.red)
                }.frame(width:width)
                
            }
            .onReceive(timer) { _ in
                vm.updateTimer()
            }
        }
    }
}

