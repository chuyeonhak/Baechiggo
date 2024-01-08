//
//  SpinnerView.swift
//  Baechiggo
//
//  Created by chuchu on 1/5/24.
//

import SwiftUI

struct SpinnerView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(1.5, anchor: .center)
    }
}
