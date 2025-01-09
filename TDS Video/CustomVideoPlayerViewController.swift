//
//  CustomVideoPlayerViewController.swift
//  TDS Video
//
//  Created by Thomas Dye on 05/08/2024.
//

import UIKit
import AVFoundation
import MediaPlayer


class CustomVideoPlayerViewController: UIViewController {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        setupRemoteCommandCenter()
    }

    func setupPlayer(url: URL) {
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        guard let playerLayer = playerLayer else { return }

        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspect
        view.layer.insertSublayer(playerLayer, at: 0)
        
        // Set up Now Playing Info
        setupNowPlayingInfo()
    }
    
    func setupPlayer(player: AVPlayer) {
        self.player = player
        playerLayer = AVPlayerLayer(player: self.player)
        guard let playerLayer = playerLayer else { return }

        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resize
        view.layer.insertSublayer(playerLayer, at: 0)
        
        // Set up Now Playing Info
        setupNowPlayingInfo()
    }
    
    func setupPlayerlayer(playerLayer: AVPlayerLayer) {
        
        self.playerLayer = playerLayer

        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resize
        view.layer.insertSublayer(playerLayer, at: 0)
        
        // Set up Now Playing Info
        setupNowPlayingInfo()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
        updateNowPlayingInfo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }

    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player?.rate == 0.0 {
                self.player?.play()
                self.updateNowPlayingInfo()
                return .success
            }
            return .commandFailed
        }

        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.player?.rate != 0.0 {
                self.player?.pause()
                self.updateNowPlayingInfo()
                return .success
            }
            return .commandFailed
        }

        commandCenter.togglePlayPauseCommand.addTarget { [unowned self] event in
            if self.player?.rate == 0.0 {
                self.player?.play()
            } else {
                self.player?.pause()
            }
            self.updateNowPlayingInfo()
            return .success
        }

        commandCenter.skipForwardCommand.addTarget { [unowned self] event in
            self.skipForward()
            self.updateNowPlayingInfo()
            return .success
        }

        commandCenter.skipBackwardCommand.addTarget { [unowned self] event in
            self.skipBackward()
            self.updateNowPlayingInfo()
            return .success
        }

        commandCenter.skipForwardCommand.preferredIntervals = [15] // Skip forward 15 seconds
        commandCenter.skipBackwardCommand.preferredIntervals = [15] // Skip backward 15 seconds
    }

    func setupNowPlayingInfo() {
        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = [String: Any]()

        nowPlayingInfo[MPMediaItemPropertyTitle] = "Video Title"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "Artist Name"

        if let player = player, let currentItem = player.currentItem {
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = CMTimeGetSeconds(currentItem.asset.duration)
        }

        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }

    func updateNowPlayingInfo() {
        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()

        if let player = player, let currentItem = player.currentItem {
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(player.currentTime())
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
        }

        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }

    func skipForward() {
        guard let player = player, let currentItem = player.currentItem else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 15.0
        if newTime < CMTimeGetSeconds(currentItem.duration) {
            let time = CMTimeMakeWithSeconds(newTime, preferredTimescale: currentItem.asset.duration.timescale)
            player.seek(to: time)
        }
    }

    func skipBackward() {
        guard let player = player else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = max(currentTime - 15.0, 0)
        let time = CMTimeMakeWithSeconds(newTime, preferredTimescale: player.currentItem?.asset.duration.timescale ?? 1)
        player.seek(to: time)
    }
}
