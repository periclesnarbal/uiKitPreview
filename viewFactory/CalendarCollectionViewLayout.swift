//
//  CalendarCollectionViewLayout.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 22/08/22.
//

import UIKit

class CalendarCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        minimumInteritemSpacing = 0.0
        minimumLineSpacing = 0.0
        sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        sectionInsetReference = .fromContentInset
        
        let availableWidth: Double = collectionView.bounds.width
        let maxNumColumns = 7
        let cellWidth: Double = ((availableWidth) / Double(maxNumColumns))
        
        itemSize = CGSize(width: cellWidth, height: cellWidth)
    }
}
