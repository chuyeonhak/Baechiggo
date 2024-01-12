//
//  MatchTableView.swift
//  Baechiggo
//
//  Created by chuchu on 1/8/24.
//

import SwiftUI

struct MatchTableView: View {
    @State var matchModel: NotionInfo
    @State var matchDataList: [NotionData] = []
    @State var isSpinnerShow: Bool = true
    var body: some View {
        ZStack {
            Form {
                ForEach(Array(zip(matchDataList.indices, matchDataList)), id: \.0) { index, list in
                    Section("제 \(index + 1) 경기") {
                        ForEach(list.results, id: \.id, content: nameView)
                    }
                }
            }
            .allowsHitTesting(!isSpinnerShow)
            .onAppear(perform: requestMatchData)
            if isSpinnerShow {
                SpinnerView()
            }
        }
    }
    
    func nameView(data: NotionInfo) -> some View {
        HStack {
            HStack {
                Text(data.properties?.team새롬?.relation?.first?.name ?? "")
                Text(data.properties?.team새롬?.relation?.last?.name ?? "")
            }
            Text("vs")
                .padding(.horizontal, 6)
            
            HStack {
                Text(data.properties?.team진우?.relation?.first?.name ?? "")
                Text(data.properties?.team진우?.relation?.last?.name ?? "")
            }
        }
    }
    
    private func requestMatchData() {
        Task {
            do {
                let requestType: NetworkManager.NetworkType = .matchData(matchModel.idString)
                let data = try await NetworkManager.shared.requestAPI(requestType)
                guard let data else { return }
                
                let json = try JSONDecoder().decode(NotionData.self, from: data)
                let databaseList = await json.results
                    .filter(\.isDatabase)
                    .map(\.idString)
                    .asyncCompactMap(requestData)
                
                isSpinnerShow = false
                matchDataList = databaseList
            }
        }
    }
    
    private func requestData(databaseID: String) async -> NotionData? {
        guard let data = try? await NetworkManager.shared.requestAPI(.queryDataBase(databaseID)),
              let json = try? JSONDecoder().decode(NotionData.self, from: data)
        else { return nil }
        
        print("성공")
        return json
    }
}
