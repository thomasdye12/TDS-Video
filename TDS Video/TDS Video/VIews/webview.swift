//
//  webview.swift
//  TDS Video
//
//  Created by Thomas Dye on 05/08/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewControllerRepresentable {
//    var url: URL
    
    func makeUIViewController(context: Context) -> CustomWebViewController {
        let webViewController = CustomWebViewController.shared
        CustomWebViewController.shared.IsIncar = false
        return webViewController
    }

    func updateUIViewController(_ uiViewController: CustomWebViewController, context: Context) {
//        uiViewController.loadURL(url)
    }
    
    
}

struct WebViewContainer: View {
    @State private var showURLInput: Bool = false
    @State private var userInputURL: String = ""

    var body: some View {
        VStack {
            WebView()

            Spacer()
        }
        .toolbar(content: {
            Button("Reload", action: {
                showURLInput = true
            })
            Button("Car Load", action: {
                TDSVideoShared.shared.CarPlayComp?(.init(type: .web, URL: nil))
            })
        })
        .sheet(isPresented: $showURLInput) {
            URLInputSheet(showURLInput: $showURLInput, userInputURL: $userInputURL)
        }
        .ignoresSafeArea(.all)
    }
}

struct URLInputSheet: View {
    @Binding var showURLInput: Bool
    @Binding var userInputURL: String

    var body: some View {
        VStack {
            Text("Enter URL")
                .font(.headline)
                .padding()

            TextField("Enter URL", text: $userInputURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Load URL") {
                if let url = URL(string: userInputURL) {
                    CustomWebViewController.shared.loadURL(url)
                } else {
                    // Handle invalid URL if necessary
                    print("Invalid URL")
                }
                showURLInput = false
            }
            .padding()
            
            Button("Load Shared URL \(loadSharedURL()?.absoluteString ?? "")") {
                if let url =  loadSharedURL() {
                    CustomWebViewController.shared.loadURL(url)
                } else {
                    // Handle invalid URL if necessary
                    print("Invalid URL")
                }
                showURLInput = false
            }
            .padding()

            Button("Cancel") {
                showURLInput = false
            }
            .padding()
        }
        .padding()
    }
    // if let sharedURL = loadSharedURL() {
    
    func loadSharedURL() -> URL? {
        let shared = TDSVideoShared.shared.loadSharedURL()
        if let sharedURL = shared {
            return sharedURL
        }
        return nil
    }
}
