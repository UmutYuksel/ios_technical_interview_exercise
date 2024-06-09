//
//  PollsCollectionViewCell.swift
//  Pollexa
//
//  Created by Umut Yüksel on 7.06.2024.
//

import UIKit

protocol PollsCollectionViewCellDelegate: AnyObject {
    func voteForOption(pollIndex: Int, optionIndex: Int)
}

class PollsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastVoteLabel: UILabel!
    @IBOutlet weak var pollDescriptionLabel: UILabel!
    @IBOutlet weak var optionOneImageView: UIImageView!
    @IBOutlet weak var optionTwoImageView: UIImageView!
    @IBOutlet weak var totalVoteCountLabel: UILabel!
    
    var pollIndex : Int?
    var delegate : PollsCollectionViewCellDelegate?
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // optionOneImageView'a tıklama tanıyıcı ekle
            let tapGestureOne = UITapGestureRecognizer(target: self, action: #selector(optionOneTapped))
            optionOneImageView.addGestureRecognizer(tapGestureOne)
            optionOneImageView.isUserInteractionEnabled = true
            
            // optionTwoImageView'a tıklama tanıyıcı ekle
            let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(optionTwoTapped))
            optionTwoImageView.addGestureRecognizer(tapGestureTwo)
            optionTwoImageView.isUserInteractionEnabled = true
        }
    
    @objc func optionOneTapped() {
           if let pollIndex = pollIndex {
               delegate?.voteForOption(pollIndex: pollIndex, optionIndex: 0)
           } else {
               print("pollIndex is nil for option 1")
           }
       }
       
       @objc func optionTwoTapped() {
           if let pollIndex = pollIndex {

               delegate?.voteForOption(pollIndex: pollIndex, optionIndex: 1)
           } else {
               print("pollIndex is nil for option 2")
           }
       }
    
    func configure(with post: Post, pollIndex: Int, delegate: PollsCollectionViewCellDelegate) {
        self.pollIndex = pollIndex
        self.delegate = delegate
        // Tarih bilgileri
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        createdDateLabel.text = "\(dateFormatter.string(from: post.createdAt)) days ago"
        // Kullanıcı bilgileri
        userImageView.image = post.user?.image
        userNameLabel.text = post.user?.username
        pollDescriptionLabel.text = post.content
        optionOneImageView.image = post.options[0].image
        optionTwoImageView.image = post.options[1].image
        totalVoteCountLabel.text = "\(post.totalVote ?? 0) Total Votes"
        
        if let lastVotedAt = post.lastVoteAt {
            let timeInterval = Date().timeIntervalSince(lastVotedAt)
            
            if timeInterval < 60 {
                let seconds = Int(timeInterval)
                lastVoteLabel.text = "Last voted \(seconds) second\(seconds != 1 ? "s" : "") ago"
            } else if timeInterval < 3600 {
                let minutes = Int(timeInterval / 60)
                lastVoteLabel.text = "Last voted \(minutes) minute\(minutes != 1 ? "s" : "") ago"
            } else if timeInterval < 86400 {
                let hours = Int(timeInterval / 3600)
                lastVoteLabel.text = "Last voted \(hours) hour\(hours != 1 ? "s" : "") ago"
            } else {
                let days = Int(timeInterval / 86400)
                lastVoteLabel.text = "Last voted \(days) day\(days != 1 ? "s" : "") ago"
            }
        } else {
            lastVoteLabel.text = "No votes yet"
        }
        
    }
}
