//
//  MatchView.swift
//  Baechiggo
//
//  Created by chuchu on 1/5/24.
//

import SwiftUI

struct MatchView: View {
    @State var isSpinnerShow: Bool = true
    @State var matchList: [NotionInfo] = []
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    ForEach(matchList, id: \.id) { data in
                        let title = data.childPage?.title ?? ""
                        NavigationLink(title) { MatchTableView(matchModel: data) }
                    }
                }
            }
            
            if isSpinnerShow {
                SpinnerView()
            }
        }
        .onAppear(perform: getMatchDataList)
        .navigationTitle("경기 리스트")
    }
    
    private func getMatchDataList() {
        NetworkManager.shared.requestAPI(.matchDataList) {
            switch $0.result {
            case .success(let data):
                guard let data else { return }
                do {
                    let json = try JSONDecoder().decode(NotionData.self, from: data)
                    matchList = json.results
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
}
