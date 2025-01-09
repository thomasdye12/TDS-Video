//
//  WebViewButtons.swift
//  TDS Video
//
//  Created by Thomas Dye on 06/08/2024.
//

import SwiftUI

struct WebViewButtons: View {
    @State var buttonColour: Color = .purple
    @State var centerButtonColour: Color = .purple
    let Size: CGFloat = 300
    var isTV: Bool = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.moveCursorUp(by: 10)
                    }) {
                        Image(systemName: "chevron.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    .simultaneousGesture(longPressGesture { CustomWebViewController.shared.moveCursorUp(by: 50) })
                    Spacer()
                }
                Spacer()
                HStack {
                    Button(action: {
                        CustomWebViewController.shared.moveCursorLeft(by: 10)
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(width: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    .simultaneousGesture(longPressGesture { CustomWebViewController.shared.moveCursorLeft(by: 50) })
                    Spacer()
                    
                    Button(action: {
                        CustomWebViewController.shared.select()
                    }) {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: Size / 3, height:  Size / 3)
                                .foregroundColor(centerButtonColour)
                                .cornerRadius(35)
                                .shadow(color: .gray, radius: 10, x: 0, y: 0)
                            Text("Select")
                                .foregroundColor(buttonColour)
                        }
                    }

                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.moveCursorRight(by: 10)
                    }) {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(width: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    .simultaneousGesture(longPressGesture { CustomWebViewController.shared.moveCursorRight(by: 50) })
                    
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.moveCursorDown(by: 10)
                    }) {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    .simultaneousGesture(longPressGesture { CustomWebViewController.shared.moveCursorDown(by: 50) })
                    Spacer()
                }
            }
            .frame(width: Size, height: Size)
            .fixedSize(horizontal: true, vertical: true)
            .padding()
            .background(colorScheme == .dark ? Color.black : Color.white)
            .clipShape(Circle())
            .shadow(color: .gray, radius: 20, x: 0, y: 0)

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.scrollBy(x: 0, y: -100)
                    }) {
                        Image(systemName: "arrow.up.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.scrollBy(x: 0, y: 100)
                    }) {
                        Image(systemName: "arrow.down.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.resizeContent(by: 1.1)
                    }) {
                        Image(systemName: "plus.magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.resetZoom()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.resizeContent(by: 0.9)
                    }) {
                        Image(systemName: "minus.magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.resize(by: 1.1)
                    }) {
                        Image(systemName: "plus.magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.resize(by: 0.9)
                    }) {
                        Image(systemName: "minus.magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                }
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.moveHorizontally(by: -10)
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.moveHorizontally(by: 10)
                    }) {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                }
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.moveVertically(by: -10)
                    }) {
                        Image(systemName: "chevron.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.moveVertically(by: 10)
                    }) {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                }
                
                
                
                HStack {
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.resetZoom()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    Button(action: {
                        CustomWebViewController.shared.toggleCursor()
                    }) {
                        Image("Cursor")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                    // ToggleCursor
                    Button(action: {
                        CustomWebViewController.shared.reloadPage()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.largeTitle)
                            .frame(height: Size / 7)
                            .foregroundColor(buttonColour)
                            .fixedSize()
                    }
                    Spacer()
                }
            }
        }
    }
    
    private func longPressGesture(action: @escaping () -> Void) -> some Gesture {
        LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                action()
            }
    }
}


#Preview {
    WebViewButtons()
}
