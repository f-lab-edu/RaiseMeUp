//
//  ExerciseListHeader.swift
//  RaiseMeUp-PROD
//
//  Created by 홍석현 on 2/10/24.
//

import SwiftUI

struct ExerciseListHeader: View {
    let title: String
    let subTitle: String
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.black)
            Text(subTitle)
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ExerciseListHeader(
        title: "Starter",
        subTitle: "한번에 턱걸이 최대 3회 이상의 초급자"
    )
}
