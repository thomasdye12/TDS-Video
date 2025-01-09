//
//  MainView.swift
//  TDS McdonaldsApi
//
//  Created by Thomas Dye on 02/08/2024.
//

import SwiftUI

struct MainView: View {
    @State private var accessToken: String = ""
    @State var orders:[McDonaldsOrder] = []
    var body: some View {
        NavigationStack {
            List {
                TextField("UploadVideo", text: $accessToken)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    uploadToken(tokenType: "", token: accessToken)
                }) {
                    Text("upload Video")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button(action: {
                    uploadToken(tokenType: "", token: TDSVideoShared.shared.loadSharedURLVideo() ?? "")
                }) {
                    Text("send shared Video")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: WebViewContainer(), label: {
                    Text("Open WebView")
                })

                Button("Car Load",action:  {
                    TDSVideoShared.shared.CarPlayComp?(.init(type: .web, URL: nil))
                })
                
                NavigationLink(destination: WebViewButtons(), label: {
                    Text("Open WebView Button")
                })

//                Button(action: {
//                    TDSVideoShared.shared.presentOnSecondScreen()
//                }) {
//                    Text("Start")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                
//                Button(action: {
//                    ScreenRecordingManager.shared.stopRecording(completion: {_,_ in}
//                    )
//                }) {
//                    Text("stop")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
                
            }
        }
    }
    
    func uploadToken(tokenType: String, token: String) {
        if let URL = URL(string: token) {
            TDSVideoShared.shared.CarPlayComp?(.init(type: .video, URL: URL))
        } else {
            ErrorHandling.Shared.showError("URL invalid")
        }
    }
    
}

#Preview {
    MainView()
}
