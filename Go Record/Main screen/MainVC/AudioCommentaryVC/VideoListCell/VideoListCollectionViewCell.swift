//
//  VideoListCollectionViewCell.swift
//  Go Record
//
//  Created by LinhMAC on 29/04/2024.
//

import UIKit
import AVFoundation
import CollectionViewPagingLayout


class VideoListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playImage: UIImageView!
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var isPlay = false
    var videoUrl : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isPlay.toggle()
//        guard let videoUrl = videoUrl else {return}
//        player = AVPlayer(url: URL(string: "file:///Users/nguyenlinh/Library/Developer/CoreSimulator/Devices/F42E079A-8DB0-4B04-9997-C3210425AB46/data/Media/DCIM/100APPLE/IMG_0014.MP4")!)
        
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
        //        let videoUrl = "file:///Users/nguyenlinh/Library/Developer/CoreSimulator/Devices/F42E079A-8DB0-4B04-9997-C3210425AB46/data/Media/DCIM/100APPLE/IMG_0014.MP4"
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
        playImage.isHidden = true
        isPlay = true
    }
    
    func pause() {
        player.pause()
        isPlay = false
        playImage.isHidden = false
        
    }
    private func updatePlayerLayerPositionAndSize() {
        // Calculate the new frame for playerLayer
        let scaledFrame = CGRect(x: 0, y: 0, width: videoView.bounds.width, height: videoView.bounds.height)
        
        // Set the frame of playerLayer
        playerLayer.frame = scaledFrame
    }
    
    
}

extension VideoListCollectionViewCell: ScaleTransformView {

    func transform(progress: CGFloat) {
        applyScaleTransform(progress: progress)
        updatePlayerLayerPositionAndSize()

        // customize views here, like this:
        //        contentView.alpha = 1 - abs(progress)

        //        subtitleLabel.alpha = titleLabel.alpha
    }
    var scaleOptions: ScaleTransformViewOptions {
        .layout(.easeOut)

    }


}

