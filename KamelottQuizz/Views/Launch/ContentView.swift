//
//  ContentView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/9/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Kaamelott")
                .font(.headline)
           
            Image("kaamelott")
                .resizable()
                .fixedSize()
                
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
