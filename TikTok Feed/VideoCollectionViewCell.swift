//
//  VideoCollectionViewCell.swift
//  TikTok Feed
//
//  Created by Adlet Zhantassov on 25.10.2022.
//

import UIKit
import AVFoundation

protocol VideoCollectionViewCellDelegate: AnyObject {
    func didTapLikeButton(with model: VideoModel)
    func didTapProfileButton(with model: VideoModel)
    func didTapShareButton(with model: VideoModel)
    func didTapCommentButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    //labels
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let audioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    //buttons
    private let profileButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        return button
    }()
    //delegate
    weak var delegate: VideoCollectionViewCellDelegate?
    
    //Subviews
    var player: AVPlayer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    private func addSubviews() {
        contentView.addSubview(userNameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audioLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: VideoModel) {
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else { return }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
//        playerView.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
}
