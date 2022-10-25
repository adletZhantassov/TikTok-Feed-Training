//
//  VideoCollectionViewCell.swift
//  TikTok Feed
//
//  Created by Adlet Zhantassov on 25.10.2022.
//

import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    //Subviews
    var player: AVPlayer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: VideoModel) {
        contentView.backgroundColor = .red
    }
}
