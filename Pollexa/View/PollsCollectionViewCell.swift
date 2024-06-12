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
    
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastVoteLabel: UILabel!
    @IBOutlet weak var pollDescriptionLabel: UILabel!
    @IBOutlet weak var optionOneImageView: UIImageView!
    @IBOutlet weak var optionTwoImageView: UIImageView!
    @IBOutlet weak var totalVoteCountLabel: UILabel!
    
    var optionOneLabel: UILabel!
    var optionTwoLabel : UILabel!

    
    var pollIndex : Int?
    var delegate : PollsCollectionViewCellDelegate?
    
    var viewModel: PostCollectionViewModel? {
            didSet {
                configure(with: viewModel)
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        addTapGestureOptionImageViews()
        setupLabels()
        makeCircularLikeButtons()
        
    }
    
    private func addTapGestureOptionImageViews() {
        // optionOneImageView'a tıklama tanıyıcı ekle
        let tapGestureOne = UITapGestureRecognizer(target: self, action: #selector(optionOneTapped))
        optionOneImageView.addGestureRecognizer(tapGestureOne)
        optionOneImageView.isUserInteractionEnabled = true
            
        // optionTwoImageView'a tıklama tanıyıcı ekle
        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(optionTwoTapped))
        optionTwoImageView.addGestureRecognizer(tapGestureTwo)
        optionTwoImageView.isUserInteractionEnabled = true
    }
    
    private func setupLabels() {
        // UILabel oluştur ve ayarla
        optionOneLabel = UILabel()
        optionOneLabel.translatesAutoresizingMaskIntoConstraints = false
        optionOneLabel.backgroundColor = UIColor.clear
        optionOneLabel.textColor = .white
        optionOneLabel.textAlignment = .right
        contentView.addSubview(optionOneLabel)
        
        // OptionTwoLabel için özelliklerini ayarla
        optionTwoLabel = UILabel()
        optionTwoLabel.textAlignment = .right // Sağa hizalı
        optionTwoLabel.backgroundColor = UIColor.clear
        optionTwoLabel.textColor = .white
        optionTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(optionTwoLabel)
            
        NSLayoutConstraint.activate([
        optionTwoLabel.trailingAnchor.constraint(equalTo: optionTwoImageView.trailingAnchor, constant: -10),
        optionTwoLabel.bottomAnchor.constraint(equalTo: optionTwoImageView.bottomAnchor, constant: -10)
        ])
                
        // optionOneLabel için kısıtlamaları ayarla
        NSLayoutConstraint.activate([
        optionOneLabel.trailingAnchor.constraint(equalTo: optionOneImageView.trailingAnchor, constant: -10),
        optionOneLabel.bottomAnchor.constraint(equalTo: optionOneImageView.bottomAnchor, constant: -10)
        ])
    }
    
    private func makeCircularLikeButtons() {
        optionOneButton.makeCircular()
        optionTwoButton.makeCircular()
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
    
    func configure(with viewModel: PostCollectionViewModel?) {
        
        guard let viewModel = viewModel else {
            // View model nil ise, hücreyi boş duruma getir
            // Örneğin, imageViews, labels ve diğer özelliklerin sıfırlanması
            return
        }
            
        createdDateLabel.text = viewModel.createdAt
        userImageView.image = viewModel.userImage
        userNameLabel.text = viewModel.username
        pollDescriptionLabel.text = viewModel.content
        optionOneImageView.image = viewModel.optionOneImage
        optionTwoImageView.image = viewModel.optionTwoImage
        if viewModel.optionOnePercentage == "0%" && viewModel.optionTwoPercentage == "0%" {
            optionOneLabel.isHidden = true
            optionTwoLabel.isHidden = true
            optionOneButton.isHidden = false
            optionTwoButton.isHidden = false
        } else {
            optionOneButton.isHidden = true
            optionTwoButton.isHidden = true
            optionOneLabel.isHidden = false
            optionTwoLabel.isHidden = false
            optionOneLabel.text = viewModel.optionOnePercentage
            optionTwoLabel.text = viewModel.optionTwoPercentage
        }

        totalVoteCountLabel.text = "\(viewModel.totalVotes) Total Votes"
            
        if let lastVoteAt = viewModel.lastVoteAt {
            let timeInterval = Date().timeIntervalSince(lastVoteAt)
            
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
