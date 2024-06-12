//
//  PollsCollectionViewCell.swift
//  Pollexa
//
//  Created by Umut Yüksel on 7.06.2024.
//

import UIKit

// MARK: - PollsCollectionViewCellDelegate
protocol PollsCollectionViewCellDelegate: AnyObject {
    func voteForOption(pollIndex: Int, optionIndex: Int)
}

class PollsCollectionViewCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastVoteLabel: UILabel!
    @IBOutlet weak var pollDescriptionLabel: UILabel!
    @IBOutlet weak var optionOneImageView: UIImageView!
    @IBOutlet weak var optionTwoImageView: UIImageView!
    @IBOutlet weak var totalVoteCountLabel: UILabel!
    
    // MARK: Properties
    var optionOneLabel: UILabel!
    var optionTwoLabel : UILabel!
    var optionOneButton: UIButton!
    var optionTwoButton: UIButton!

    
    var pollIndex : Int?
    var delegate : PollsCollectionViewCellDelegate?
    
    var viewModel: PostCollectionViewModel? {
            didSet {
                configure(with: viewModel)
            }
        }
    // MARK: Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastVoteLabel.translatesAutoresizingMaskIntoConstraints = false
        pollDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionOneImageView.translatesAutoresizingMaskIntoConstraints = false
        optionTwoImageView.translatesAutoresizingMaskIntoConstraints = false
        totalVoteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addTapGestureOptionImageViews()
        setupButtons()
        setupLabels()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        optionOneButton.makeCircular()
        optionTwoButton.makeCircular()
    }

    
    private func addTapGestureOptionImageViews() {
        
        let tapGestureOne = UITapGestureRecognizer(target: self, action: #selector(optionOneTapped))
        optionOneImageView.addGestureRecognizer(tapGestureOne)
        optionOneImageView.isUserInteractionEnabled = true
            
        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(optionTwoTapped))
        optionTwoImageView.addGestureRecognizer(tapGestureTwo)
        optionTwoImageView.isUserInteractionEnabled = true
    }
    
    private func setupLabels() {
        
        optionOneLabel = UILabel()
        optionOneLabel.translatesAutoresizingMaskIntoConstraints = false
        optionOneLabel.backgroundColor = UIColor.clear
        optionOneLabel.textColor = .white
        optionOneLabel.textAlignment = .right
        contentView.addSubview(optionOneLabel)
        

        optionTwoLabel = UILabel()
        optionTwoLabel.textAlignment = .right
        optionTwoLabel.backgroundColor = UIColor.clear
        optionTwoLabel.textColor = .white
        optionTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(optionTwoLabel)
            
        NSLayoutConstraint.activate([
        optionTwoLabel.trailingAnchor.constraint(equalTo: optionTwoImageView.trailingAnchor, constant: -10),
        optionTwoLabel.bottomAnchor.constraint(equalTo: optionTwoImageView.bottomAnchor, constant: -10)
        ])
                

        NSLayoutConstraint.activate([
        optionOneLabel.trailingAnchor.constraint(equalTo: optionOneImageView.trailingAnchor, constant: -10),
        optionOneLabel.bottomAnchor.constraint(equalTo: optionOneImageView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupButtons() {
        // Option One Button
        optionOneButton = UIButton(type: .system)
        optionOneButton.translatesAutoresizingMaskIntoConstraints = false
        optionOneButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        optionOneButton.backgroundColor = .white
        contentView.addSubview(optionOneButton)
        
        // Option Two Button
        optionTwoButton = UIButton(type: .system)
        optionTwoButton.translatesAutoresizingMaskIntoConstraints = false
        optionTwoButton.setBackgroundImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        optionTwoButton.backgroundColor = .white
        
        contentView.addSubview(optionTwoButton)
    
        // Auto Layout Constraints for Option One Button
        NSLayoutConstraint.activate([
            optionOneButton.widthAnchor.constraint(equalToConstant: 30),
            optionOneButton.heightAnchor.constraint(equalToConstant: 30),
            optionOneButton.leadingAnchor.constraint(equalTo: optionOneImageView.leadingAnchor, constant: 10),
            optionOneButton.bottomAnchor.constraint(equalTo: optionOneImageView.bottomAnchor, constant: -10)
        ])
            
        // Auto Layout Constraints for Option Two Button
        NSLayoutConstraint.activate([
            optionTwoButton.widthAnchor.constraint(equalToConstant: 30),
            optionTwoButton.heightAnchor.constraint(equalToConstant: 30),
            optionTwoButton.leadingAnchor.constraint(equalTo: optionTwoImageView.leadingAnchor, constant: 10),
            optionTwoButton.bottomAnchor.constraint(equalTo: optionTwoImageView.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: Action Methods
    
    @objc func optionOneTapped() {
        guard let pollIndex = pollIndex else {
            print("pollIndex is nil for option 1")
            return
        }
        delegate?.voteForOption(pollIndex: pollIndex, optionIndex: 0)
    }

    @objc func optionTwoTapped() {
        guard let pollIndex = pollIndex else {
            print("pollIndex is nil for option 2")
            return
        }
        delegate?.voteForOption(pollIndex: pollIndex, optionIndex: 1)
    }
    
    // MARK: Configure Method
    func configure(with viewModel: PostCollectionViewModel?) {
        
        guard let viewModel = viewModel else {
            return
        }
            
        createdDateLabel.text = viewModel.createdAt
        userImageView.image = viewModel.userImage
        userNameLabel.text = viewModel.username
        pollDescriptionLabel.text = viewModel.content
        optionOneImageView.image = viewModel.optionOneImage
        optionTwoImageView.image = viewModel.optionTwoImage
        if viewModel.optionOnePercentage == "0%" && viewModel.optionTwoPercentage == "0%" {
            optionOneButton.isHidden = false
            optionTwoButton.isHidden = false
            optionOneLabel.isHidden = true
            optionTwoLabel.isHidden = true

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
