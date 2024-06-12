//
//  DiscoverViewController.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit

class DiscoverViewController: UIViewController {
   
    // MARK: - Outlets
    
    @IBOutlet weak var activePollsLabel: UILabel!
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
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        pollsCollectionView.delegate = self
        pollsCollectionView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        print("Add Button Pressed")
    }
    
    }
    
// MARK: - UICollectionViewDataSource and UICollectionViewDelegate

extension DiscoverViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PollCollectionViewCell", for: indexPath) as! PollsCollectionViewCell
        let post = viewModel.posts[indexPath.row]
        let postViewModel = PostCollectionViewModel(post: post)
        cell.configure(with: postViewModel)
        cell.pollIndex = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 319)
    }
}

// MARK: - DiscoverViewModelDelegate

extension DiscoverViewController: DiscoverViewModelDelegate {
    
    func didUpdatePost() {
        DispatchQueue.main.async {
            self.pollsCollectionView.reloadData()
            let activePollsText = self.viewModel.activePollsText()
            self.activePollsLabel.text = activePollsText
        }
    }
}

// MARK: - PollsCollectionViewCellDelegate

extension DiscoverViewController: PollsCollectionViewCellDelegate {
    
    func voteForOption(pollIndex: Int, optionIndex: Int) {
        viewModel.voteForOption(pollIndex: pollIndex, optionIndex: optionIndex)
    }
}
