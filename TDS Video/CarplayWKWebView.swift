//
//  CarplayWKWebView.swift
//  TDS Video
//
//  Created by Thomas Dye on 05/08/2024.
//

import UIKit
import WebKit
import AVKit


class CustomWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    static let shared = CustomWebViewController()
    var webView: WKWebView?
    var cursorImageView: UIImageView?
    var containerView: UIView?
    var IsIncar: Bool = false
    private var zoomScale: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize and configure the container view
        containerView = UIView(frame: self.view.frame)
        containerView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(containerView!)

        // Initialize and configure the web view
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.allowsPictureInPictureMediaPlayback = true
        webView = WKWebView(frame: containerView!.bounds, configuration: config)
        webView!.scrollView.showsHorizontalScrollIndicator = false
        webView!.scrollView.showsVerticalScrollIndicator = false
        webView!.navigationDelegate = self
        webView!.uiDelegate = self
        webView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView!.addSubview(webView!)
        
        // Initialize and configure the cursor image view
        let cursorImage = UIImage(named: "Cursor") // Replace with your cursor image name
        cursorImageView = UIImageView(image: cursorImage)
        cursorImageView!.frame = CGRect(x: 100, y: 100, width: 30, height: 30) // Set initial position and size
        self.view.addSubview(cursorImageView!)
    }

    func loadURL(_ url: URL) {
        let request = URLRequest(url: url)
        webView!.load(request)
    }

    // Function to move the cursor up
    func moveCursorUp(by amount: CGFloat) {
        guard let cursorImageView = self.cursorImageView else { return }
        let newCenter = CGPoint(x: cursorImageView.center.x, y: cursorImageView.center.y - amount)
        UIView.animate(withDuration: 0.3) {
            cursorImageView.center = newCenter
        }
    }

    // Function to move the cursor down
    func moveCursorDown(by amount: CGFloat) {
        guard let cursorImageView = self.cursorImageView else { return }
        let newCenter = CGPoint(x: cursorImageView.center.x, y: cursorImageView.center.y + amount)
        UIView.animate(withDuration: 0.3) {
            cursorImageView.center = newCenter
        }
    }

    // Function to move the cursor left
    func moveCursorLeft(by amount: CGFloat) {
        guard let cursorImageView = self.cursorImageView else { return }
        let newCenter = CGPoint(x: cursorImageView.center.x - amount, y: cursorImageView.center.y)
        UIView.animate(withDuration: 0.3) {
            cursorImageView.center = newCenter
        }
    }

    // Function to move the cursor right
    func moveCursorRight(by amount: CGFloat) {
        guard let cursorImageView = self.cursorImageView else { return }
        let newCenter = CGPoint(x: cursorImageView.center.x + amount, y: cursorImageView.center.y)
        UIView.animate(withDuration: 0.3) {
            cursorImageView.center = newCenter
        }
    }

    // Function to select (click) the element at the cursor position
    func select() {
        guard let cursorImageView = self.cursorImageView else { return }
        guard let webView = self.webView else { return }
        
        // Convert cursor position to webView's coordinate system
        let cursorPointInView = cursorImageView.center
        let cursorPointInWebView = webView.convert(cursorPointInView, from: self.view)
        
        let js = "document.elementFromPoint(\(Int(cursorPointInWebView.x)), \(Int(cursorPointInWebView.y))).click();"
        webView.evaluateJavaScript(js, completionHandler: nil)
    }

    // Function to scroll the web view
    func scrollBy(x: CGFloat, y: CGFloat) {
        let js = "window.scrollBy(\(x), \(y));"
        webView?.evaluateJavaScript(js, completionHandler: nil)
    }

    func resizeContent(by scale: CGFloat) {
        zoomScale *= scale
        let js = "document.body.style.zoom = '\(zoomScale)'"
        webView?.evaluateJavaScript(js, completionHandler: nil)
    }

    // Function to resize the container view
    func resize(by scale: CGFloat) {
        // Ensure scale is positive
        guard scale > 0 else { return }

        guard let containerView = containerView else { return }
        // Get the current frame of the container view
        var currentFrame = containerView.frame

        // Calculate the new width and height
        let newWidth = currentFrame.width * scale
        let newHeight = currentFrame.height * scale

        // Optionally, maintain the center of the container view
        let currentCenter = containerView.center

        // Set the new frame size
        currentFrame.size = CGSize(width: newWidth, height: newHeight)
        containerView.frame = currentFrame

        // Optionally, set the center back to the original
        containerView.center = currentCenter
    }

    // Function to reset the zoom level to 1
    func resetZoom() {
        zoomScale = 1.0
        let js = "document.body.style.zoom = '1.0'"
        webView?.evaluateJavaScript(js, completionHandler: nil)
    }

    func reloadPage() {
        zoomScale = 1.0
        let js = "document.location.reload();"
        webView?.evaluateJavaScript(js, completionHandler: nil)
    }

    // Toggle hidden cursor
    func toggleCursor() {
        guard let cursorImageView = self.cursorImageView else { return }
        if cursorImageView.isHidden {
            UIView.animate(withDuration: 0.3) {
                cursorImageView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                cursorImageView.isHidden = true
            }
        }
    }

    // WKUIDelegate method to prevent full-screen video playback
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return nil
    }

    // WKUIDelegate method to handle JavaScript alerts
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func moveHorizontally(by offset: CGFloat) {
        guard let containerView = containerView else { return }
        var currentFrame = containerView.frame
        currentFrame.origin.x += offset
        containerView.frame = currentFrame
    }

    func moveVertically(by offset: CGFloat) {
        guard let containerView = containerView else { return }
        var currentFrame = containerView.frame
        currentFrame.origin.y += offset
        containerView.frame = currentFrame
    }
}
