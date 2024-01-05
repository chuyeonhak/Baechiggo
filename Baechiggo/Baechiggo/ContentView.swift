//
//  ContentView.swift
//  Baechiggo
//
//  Created by chuchu on 1/4/24.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    let test = "https://www.notion.so/8ad11213234d4bf0a2bc41d10254d30c?v=74171ed6b12c4aba9d05a0f2967deadb&pvs=4"
    let api = TestAPI()
    
    var body: some View {
        VStack {
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("push Test!")
        }
        .padding()
    }
    
    
    
}

#Preview {
    ContentView()
}

struct TestAPI {
    let notionHeaders : HTTPHeaders = [HTTPHeader(name: "Authorization", value: "secret_JoL2mbdes95THHhuUXUeaE29VeRr6wktvWkEusxCiOk"),
                                       HTTPHeader(name: "Notion-Version", value: "2022-06-28")]
    
    func notionRead() {
        
//    https:www.notion.so/5b4f15d72e7243f38a8ab92d430ff54b?v=1c1af0d8a3d34ea5a214703edb000946&pvs=4
        AF.request("https://api.notion.com/v1/databases/5b4f15d72e7243f38a8ab92d430ff54b/query",
                   method: .post,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: notionHeaders,
                   interceptor: nil,
                   requestModifier: nil).validate(statusCode: 200..<600).response { response in
            
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                
                do {
                    guard let prettyJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
                    print("get Json : \(prettyJson)")
                } catch {
                    print("파싱 에러 : \(error)")
                }
            case .failure(let error):
                print("응답 에러 : \(error)")
            }
        }
    }
    init() { notionRead() }
}
