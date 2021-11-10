//
//  WelcomeView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/9/2.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image("kaamelott")
            }
            .navigationTitle("Kaamelott")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
