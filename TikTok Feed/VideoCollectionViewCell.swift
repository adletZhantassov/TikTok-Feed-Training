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
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        return button
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        return button
    }()
    //delegate
    weak var delegate: VideoCollectionViewCellDelegate?
    
    private let videoContainer = UIView()
    
    //Subviews
    var player: AVPlayer?
    private var model: VideoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    private func addSubviews() {
        contentView.addSubview(videoContainer)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audioLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(likeButton)
        
        //Add actions
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
    }
    
    @objc private func didTapLikeButton() {
        guard let model = model else { return }
        delegate?.didTapLikeButton(with: model)
    }
    @objc private func didTapCommentButton() {
        guard let model = model else { return }
        delegate?.didTapCommentButton(with: model)
    }
    @objc private func didTapShareButton() {
        guard let model = model else { return }
        delegate?.didTapShareButton(with: model)
    }
    @objc private func didTapProfileButton() {
        guard let model = model else { return }
        delegate?.didTapProfileButton(with: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoContainer.frame = contentView.bounds
        //buttons
        let size = contentView.frame.size.width/8
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100
        
        shareButton.frame = CGRect(x: width-size, y: height-size, width: size, height: size)
        commentButton.frame = CGRect(x: width-size, y: height-(size*2)-10, width: size, height: size)
        likeButton.frame = CGRect(x: width-size, y: height-(size*3)-10, width: size, height: size)
        profileButton.frame = CGRect(x: width-size, y: height-(size*4)-10, width: size, height: size)
    
        //labels
        audioLabel.frame = CGRect(x: 5, y: height-60, width: width-size-10, height: 50)
        captionLabel.frame = CGRect(x: 5, y: height-80, width: width-size-10, height: 50)
        userNameLabel.frame = CGRect(x: 5, y: height-100, width: width-size-10, height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        audioLabel.text = nil
        userNameLabel.text = nil
    }
    
    public func configure(with model: VideoModel) {
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else { return }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
        
        //labels
        captionLabel.text = model.caption
        audioLabel.text = model.audioTrackName
        userNameLabel.text = model.username
    }
}
