//
//  MatchView.swift
//  Baechiggo
//
//  Created by chuchu on 1/5/24.
//

import SwiftUI

struct MatchView: View {
    @State var isSpinnerShow: Bool = true
    @State var matchList: [MatchDate] = []
    
    var body: some View {
        ZStack {
            
            List(matchList, id: \.self) { matchData in
                Text((matchData.childPage?.title)!)
            }
            .onAppear {
                NetworkManager.shared.requestAPI(.matchDataList) {
                    switch $0.result {
                    case .success(let data):
                        guard let data else { return }
                        do {
                            let json = try JSONDecoder().decode(MatchDateModel.self, from: data)
                            matchList = json.matchDateList
                            isSpinnerShow = false
                        }
                        catch {
                            print(error)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            
//            Button {
//                isSpinnerShow.toggle()
//            } label: {
//                Text("Test")
//            }.onAppear {
//                NetworkManager.shared.requestAPI(.matchDataList) {
//                    switch $0.result {
//                    case .success(let data):
//                        guard let data else { return }
//                        do {
//                            let json = try JSONDecoder().decode(MatchDateModel.self, from: data)
//                            print(json)
//                        }
//                        catch {
//                            print(error)
//                        }
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    matchList = []
//                    isSpinnerShow.toggle()
//                }
//            }

            if isSpinnerShow {
                SpinnerView()
            }
        }
        
    }
}
