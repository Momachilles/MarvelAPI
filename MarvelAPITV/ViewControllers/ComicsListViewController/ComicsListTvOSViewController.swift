//
//  ComicsListTvOSViewController.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 04/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit

class ComicsListTvOSViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Outlets
    @IBOutlet weak var comicsCollectionView: UICollectionView! {
        didSet {
            comicsCollectionView.delegate = self
            comicsCollectionView.dataSource = self
        }
    }
    
    
    // Variables
    lazy var viewModel = ComicsListViewModel()
    let originalCellSize = CGSize(width: 275, height: 354)
    let focusCellSize = CGSize(width: 290, height: 380)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
    }
    
    // MARK: - Private methods
    func setupViewController() {
    }
    
    func setupBinding() {
        
        viewModel.shouldReloadComicsListTable.signal.observeValues {[weak self] _ in
            DispatchQueue.main.async {
                self?.comicsCollectionView.reloadData()
            }
        }
        
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comics.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 310, height: 430)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = comicsCollectionView.dequeueReusableCell(withReuseIdentifier: "ComicCellIdentifier", for: indexPath) as? ComicCollectionViewCell {
            let comic = viewModel.comics.value[indexPath.row]
            cell.configureCell(comic: comic)
            return cell
        } else {
            return ComicCollectionViewCell()
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let previousItem = context.previouslyFocusedView as? ComicCollectionViewCell {
            UIView.animate(withDuration: 0.2) {
                previousItem.thumbnailImage.frame.size = self.originalCellSize
            }
        }
        
        if let nextItem = context.nextFocusedView as? ComicCollectionViewCell {
            UIView.animate(withDuration: 0.2) {
                nextItem.thumbnailImage.frame.size = self.focusCellSize
            }
        }
        
        if let context = context as? UICollectionViewFocusUpdateContext {
            if let indexPath = context.nextFocusedIndexPath {
                if (!comicsCollectionView.isScrollEnabled) {
                    comicsCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredVertically, animated: true)
                }
            }
        }
    }

}
