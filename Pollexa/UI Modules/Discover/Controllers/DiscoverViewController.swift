//
//  DiscoverViewController.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit

class DiscoverViewController: UIViewController, PollsCollectionViewCellDelegate {
   
    @IBOutlet weak var activePollsLabel: UILabel!
    @IBOutlet weak var avatarImage: UIBarButtonItem!
    @IBOutlet weak var pollsCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let viewModel = DiscoverViewModel(postProvider: PostProvider.shared as! PostProvider)

        // MARK: - Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupCollectionView()
            viewModel.delegate = self
            viewModel.fetchPosts()
        }
        
        func setupCollectionView() {
            pollsCollectionView.delegate = self
            pollsCollectionView.dataSource = self
        }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        print("Add Button Pressed")
    }
    
    }
    
    extension DiscoverViewController: DiscoverViewModelDelegate {
        // MARK: - DiscoverViewModelDelegate
        func didUpdatePost() {
            DispatchQueue.main.async {
                self.pollsCollectionView.reloadData()
                let activePollsText = self.viewModel.activePollsText()
                self.activePollsLabel.text = activePollsText
            }
        }
    }

    // MARK: - UICollectionViewDataSource and UICollectionViewDelegate
    extension DiscoverViewController: UICollectionViewDelegate , UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.posts.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PollCollectionViewCell", for: indexPath) as! PollsCollectionViewCell
            let post = viewModel.posts[indexPath.row]
            cell.configure(with: post, pollIndex: indexPath.row, delegate: self)
            return cell
        }
        
        func voteForOption(pollIndex: Int, optionIndex: Int) {
                viewModel.voteForOption(pollIndex: pollIndex, optionIndex: optionIndex)
            }
}
