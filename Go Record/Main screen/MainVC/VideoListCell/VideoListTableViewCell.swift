//
//  VideoListTableViewCell.swift
//  Go Record
//
//  Created by LinhMAC on 28/04/2024.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoDate: UILabel!
    @IBOutlet weak var videoDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.addBottomBorder()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(data: VideosList){
        videoName.text = data.videoName
        videoDate.text = data.videoDate
        videoDuration.text = data.videoDuration
    }
    
    func bindData1(data: String){
        videoName.text = data
    }
    
    
}
