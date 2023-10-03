//
//  AddNewPhotoView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/02.
//

import Foundation
import UIKit

class AddNewPhotoView: BaseView {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 32
        layout.itemSize = CGSize(width: size/3, height: size/3)
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
