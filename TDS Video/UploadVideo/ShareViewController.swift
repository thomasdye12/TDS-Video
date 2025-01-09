//
//  ShareViewController.swift
//  UploadVideo
//
//  Created by Thomas Dye on 05/08/2024.
//

import UIKit
import Social
import MobileCoreServices
import AVFoundation

class ShareViewController: SLComposeServiceViewController {
    
    override func isContentValid() -> Bool {
        return true
    }
    
    override func didSelectPost() {
        guard let item = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachments = item.attachments else {
            return
        }
        
        for attachment in attachments {
            if attachment.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                handleURL(attachment: attachment)
            } else if attachment.hasItemConformingToTypeIdentifier(kUTTypeMovie as String) {
                handleVideo(attachment: attachment)
            }
        }
    }
    
    private func handleURL(attachment: NSItemProvider) {
        attachment.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { (item, error) in
            if let url = item as? URL {
                self.saveURL(url: url)
            }
        }
    }
    
    private func handleVideo(attachment: NSItemProvider) {
        attachment.loadItem(forTypeIdentifier: kUTTypeMovie as String, options: nil) { (item, error) in
            if let url = item as? URL {
                self.saveVideo(url: url)
            }
        }
    }
    
    private func saveURL(url: URL) {
        print(url)
        // Save the URL to UserDefaults for the main app to access.
        
        let userDefaults = UserDefaults(suiteName: "group.net.thomasdye.TDS-docs")
        userDefaults?.set(url.absoluteString, forKey: "TDSSharedURL")
        userDefaults?.synchronize()
        
        // Inform the host that we're done
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    private func saveVideo(url: URL) {
        let fileManager = FileManager.default
        do {
            let containerURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.net.thomasdye.TDS-docs")
            let destinationURL = containerURL?.appendingPathComponent(url.lastPathComponent)
            
            if let destinationURL = destinationURL {
                // Check if file already exists, if so, remove it
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                
                // Copy the new file
                try fileManager.copyItem(at: url, to: destinationURL)
                print("Video saved to \(destinationURL)")
                
                // Save the file URL to UserDefaults
                let userDefaults = UserDefaults(suiteName: "group.net.thomasdye.TDS-docs")
                userDefaults?.set(url.absoluteString, forKey: "TDSSharedVideo")
                userDefaults?.synchronize()
            }
        } catch {
            print("Error saving video: \(error)")
        }
        
        // Inform the host that we're done
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func configurationItems() -> [Any]! {
        return []
    }
}
