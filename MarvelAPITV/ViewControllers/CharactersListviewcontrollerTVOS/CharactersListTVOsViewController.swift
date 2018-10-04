//
//  CharactersListTVOsViewController.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 02/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit

class CharactersListTVOsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Outlets
    @IBOutlet weak var charactersCollectionView: UICollectionView! {
        didSet {
            charactersCollectionView.delegate = self
            charactersCollectionView.dataSource = self
        }
    }
    
    
    // Variables
    lazy var viewModel = CharactersListViewModel()
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
        
        viewModel.shouldReloadCharactersListTable.signal.observeValues {[weak self] _ in
            DispatchQueue.main.async {
                self?.charactersCollectionView.reloadData()
            }
        }
        
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 310, height: 430)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCellIdentifier", for: indexPath) as? CharacterCollectionViewCell {
            let character = viewModel.characters.value[indexPath.row]
            cell.configureCell(character: character)
            return cell
        } else {
            return CharacterCollectionViewCell()
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let previousItem = context.previouslyFocusedView as? CharacterCollectionViewCell {
            UIView.animate(withDuration: 0.2) {
                previousItem.thumbnailImage.frame.size = self.originalCellSize
            }
        }
        
        if let nextItem = context.nextFocusedView as? CharacterCollectionViewCell {
            UIView.animate(withDuration: 0.2) {
                nextItem.thumbnailImage.frame.size = self.focusCellSize
            }
        }
        
        if let context = context as? UICollectionViewFocusUpdateContext {
            if let indexPath = context.nextFocusedIndexPath {
                if (!charactersCollectionView.isScrollEnabled) {
                    charactersCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredVertically, animated: true)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
