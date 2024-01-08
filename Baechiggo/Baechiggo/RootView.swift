//
//  RootView.swift
//  Baechiggo
//
//  Created by chuchu on 1/4/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Section {
                        NavigationLink("출석하기") { Text("출석하기") }
                        NavigationLink("점수계산") { MatchView() }
                    }
                }
            }
        }
    }
}
