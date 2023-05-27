//
//  ContentView.swift
//  MyMap
//
//  Created by YutaNoguchi on 2023/05/27.
//

import SwiftUI

struct ContentView: View {
    @State var inputText: String = ""
    @State var displaySearchkey = ""
    @State var displayMapType: MapType = .standard
    
    var body: some View {
        VStack {
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    displaySearchkey = inputText
                }
                .padding()
            ZStack(alignment: .bottomTrailing) {
                MapView(searchkey: displaySearchkey, mapType: displayMapType)
                
                Button {
                    if displayMapType == .standard {
                        displayMapType = .satellite
                    } else if displayMapType == .satellite {
                        displayMapType = .hybrid
                    } else {
                        displayMapType = .standard
                    }
                } label: {
                    Image(systemName:"map")
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                }
                .padding(.trailing, 20.0)
                .padding(.bottom, 30.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
