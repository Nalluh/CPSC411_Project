//
//  ContentView.swift
//  Timer
//
//  Created by Allan Cortes on 10/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var isAlarmSettingsPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("AlertMe")
                    .font(.largeTitle)
                    .padding()

                TextField("Enter your name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button {
                    isAlarmSettingsPresented = true
                } label: {
                    Text("Alarm Settings")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .navigationDestination(isPresented: $isAlarmSettingsPresented) {
                    AlarmSettingsView()
                }
                Spacer()
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
