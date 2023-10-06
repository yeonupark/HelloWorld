//
//  MyTravelView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/06.
//

import Foundation
import UIKit

class MyTravelView: BaseView {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(MyTravelCollectionViewCell.self, forCellWithReuseIdentifier: "MyTravelCollectionViewCell")
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 16
        layout.itemSize = CGSize(width: size, height: size/1.5)
        return layout
    }
    
    
    override func configure() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
