//
//  VideosBarCollectionViewCell.swift
//  Go Record
//
//  Created by LinhMAC on 06/05/2024.
//

import UIKit
import AVFoundation

class VideosBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoView: UIView!
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var isPlay = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isPlay.toggle()
        // Tạo playerLayer từ player
        playerLayer = AVPlayerLayer(player: player)
        
        // Thiết lập frame của playerLayer cho phù hợp với kích thước của videoView
        playerLayer.frame = videoView.bounds
        
        playerLayer.videoGravity = .resizeAspect
        
        // Thiết lập gravity của video
        
        // Thêm playerLayer vào videoView
        videoView.layer.addSublayer(playerLayer)
    }
    func blindata(data: VideosList){
        guard let videoUrl = data.videoUrl else {return}
//        self.videoUrl = videoUrl
//        print("videoUrl:\(videoUrl)")
        player = AVPlayer(url: URL(string: videoUrl)!)
        playerLayer.player = player
        
    }
    
    func controlVideo(){
        if isPlay {
            pause()
        } else {
            play()
        }
    }
    
    func play() {
        player.play()
        //        playImage.isHidden = true
        isPlay = true
    }
    
    func pause() {
        player.pause()
        isPlay = false
        //        playImage.isHidden = false
    }
}
