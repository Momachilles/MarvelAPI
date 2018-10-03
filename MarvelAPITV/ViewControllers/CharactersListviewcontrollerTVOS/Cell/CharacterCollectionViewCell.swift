//
//  CharacterCollectionViewCell.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 03/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Setup
    func configureCell(character: ComicCharacter) {
        if let title = character.name {
            nameLabel.text = title
        }
        
        DispatchQueue.global(qos: DispatchQoS.default.qosClass).async {
            if let url = character.thumbnail?.url {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let img = UIImage(data: data)
                        self.thumbnailImage.image = img
                    }
                } catch {
                    print("ERROR: \(error)")
                }
            }
        }
    }
}
