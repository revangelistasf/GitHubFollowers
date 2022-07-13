//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 13/07/22.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let viewWidth = view.bounds.width
        let padding: CGFloat = 12
        let spacing: CGFloat = 10
        let numberOfColumns: CGFloat = 3
        let availableWidth = viewWidth - (padding * 2) - (spacing * 2)
        let cellWidth = availableWidth / numberOfColumns
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return flowLayout
    }
}
