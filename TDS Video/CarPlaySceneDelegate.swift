//
//  CarPlaySceneDelegate.swift
//  TDS doc store
//
//  Created by thomas on 23/09/2022.
//

import CarPlay
import UIKit
import AVKit


extension CPTemplateApplicationScene {
    
    
    
    func _shouldCreateCarWindow(){
        print("CPTemplateApplicationScene")
    }
}



class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate, CPMapTemplateDelegate {
    
    var window: UIWindow?
    var interfaceController: CPInterfaceController?
    var player: AVPlayer?
    var playerViewController: CustomVideoPlayerViewController?
    var webViewController:CustomWebViewController?
    var templateApplicationScene: CPTemplateApplicationScene?
    var mapTemplate: CPMapTemplate?
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        
        let bool:Bool = templateApplicationScene._shouldCreateCarWindow()
        print(bool)
        
    }
    
    
    //
    //
    //    func deliveringInterfaceControllerToDelegate(_ interfaceController: CPInterfaceController) {
    //        print("this is here ")
    //    }
    //
    //     func  _deliverInterfaceControllerToDelegate(_ interfaceController: CPInterfaceController) {
    //        print("this is here ")
    //    }
    
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                  didConnect interfaceController: CPInterfaceController, to window: CPWindow) {
        

        let bool:Bool = templateApplicationScene._shouldCreateCarWindow()
        print(bool)
        /*emplateApplicationScene.test()*/
        
        self.interfaceController = interfaceController
        print(templateApplicationScene.carWindow.isUserInteractionEnabled)
//        self.interfaceController._carwin
        window.windowLevel = .normal
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        TDSVideoShared.shared.window = window
        self.window = window

        //        print(self.window?.screen)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//            //            self.loadWebPage(url: URL(string: "https://thomasdye.net")!)
//        })
        TDSVideoShared.shared.CarPlayComp = { url in
            if url.type == .video {
                self.playVideo(url: url.URL!)
            } else if url.type == .web {
                self.loadWebPage()
            } else if url.type == .rawVideo {
                self.rawVideo(player: url.AVplayer)
            }
            
            
        }
        
//            let test = CPBarButton()
//        let mapTemplate = CPMapTemplate()
//             mapTemplate.mapDelegate = self
             
             // Set the map template as the root template
//        interfaceController.setRootTemplate(CPGridTemplate(title: "tital", gridButtons: [CPGridButton(titleVariants: ["name"], image: UIImage(systemName: "door.left.hand.closed")!, handler: { _ in print("hello")
//            
//        })]), animated: true)
        
    }
    
    
    
    func rawVideo(player:AVPlayer?) {

        guard let player else { return }
        let newPlayer = CustomVideoPlayerViewController()
        
        if let rootViewController = self.window?.rootViewController {
            rootViewController.addChild(newPlayer)
            rootViewController.view.addSubview(newPlayer.view)
            newPlayer.view.frame = rootViewController.view.bounds
            newPlayer.didMove(toParent: rootViewController)
            newPlayer.setupPlayer(player: player)
            //                playerViewController.
            //                       playerViewController.setupPlayer(url: url)
        }
    }
    
    
    func playVideo(url:URL) {
                self.playerViewController = nil
                self.window?.rootViewController = UIViewController()
            
//        
        self.playerViewController = CustomVideoPlayerViewController()
     
        guard let playerViewController = playerViewController else { return }
//        playerViewController.player = AVPlayer(url: url)
        
                if let rootViewController = self.window?.rootViewController  {
                    rootViewController.addChild(playerViewController)
                    rootViewController.view.addSubview(playerViewController.view)
                    playerViewController.view.frame = rootViewController.view.bounds
                    playerViewController.didMove(toParent: rootViewController)
                    //                playerViewController.
                    playerViewController.setupPlayer(url: url)
                }
        
        

//        let player  = AVPlayerViewController()
//                player.player = AVPlayer(url: url)
//        //        player.volumeControlsCanShowSlider = false
//
//        
//        let playerViewController = player
//        
//        
//        if let rootViewController = ErrorHandling.Shared.MainVC {
//            rootViewController.addChild(playerViewController)
//            rootViewController.view.addSubview(playerViewController.view)
//            playerViewController.view.frame = rootViewController.view.bounds
//            playerViewController.didMove(toParent: rootViewController)
//            //                playerViewController.
//            //                       playerViewController.setupPlayer(url: url)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//            let avcontent = playerViewController.player
//            let newPlayer = CustomVideoPlayerViewController()
//         
//            if let rootViewController = self.window?.rootViewController {
//                rootViewController.addChild(newPlayer)
//                rootViewController.view.addSubview(newPlayer.view)
//                newPlayer.view.frame = rootViewController.view.bounds
//                newPlayer.didMove(toParent: rootViewController)
//                newPlayer.setupPlayer(player: avcontent!)
//                //                playerViewController.
//                //                       playerViewController.setupPlayer(url: url)
//            }
//            
//            
//        })
    }

        


    
 
    func loadWebPage() {

        for subview in window!.subviews {
            subview.removeFromSuperview()
            print(subview)
        }
        
         self.window?.isUserInteractionEnabled = true
         self.window?.rootViewController = UIViewController()
         self.window?.rootViewController?.view.isUserInteractionEnabled = true

         // Use the shared instance of CustomWebViewController
         self.webViewController = CustomWebViewController.shared
         guard let webViewController = self.webViewController else { return }

         // Properly add the CustomWebViewController's view to the window
         if let rootViewController = self.window?.rootViewController {
             CustomWebViewController.shared.IsIncar = true
             rootViewController.addChild(webViewController)
             rootViewController.view.addSubview(webViewController.view)
             webViewController.view.frame = rootViewController.view.bounds
             webViewController.didMove(toParent: rootViewController)
//             webViewController.view.isUserInteractionEnabled = true
         }
        
    }
}


