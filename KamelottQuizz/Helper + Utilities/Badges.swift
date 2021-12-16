//
//  Badges.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/12/16.
//

import SwiftUI

extension Image {
    func badgeImage(isUnlocked: Bool) -> some View {
        self
            .resizable()
            .frame(width: 55, height: 55)
            .padding(.horizontal)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .opacity(isUnlocked ? 1.0 : 0.5)
            .saturation(isUnlocked ? 1.0 : 0.0)
    }
}

