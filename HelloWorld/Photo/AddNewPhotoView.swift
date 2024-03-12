//
//  AddNewPhotoView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/02.
//

import Foundation
import UIKit

class AddNewPhotoView: BaseView {
    
    let notiLabel = {
        let view = UILabel()
        view.font = UIFont(name: Constant.FontName.regular, size: 16)
        view.text = "각종 티켓, 예약 확인증, 캡쳐본, 사본 등 \n여행에 필요한 이미지를 저장해보세요 🐠"
        view.numberOfLines = 0
        view.textAlignment = .center
        
        return view
    }()
    
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
        layout.itemSize = CGSize(width: size/3, height: size/2.5)
        return layout
    }
    
    override func configure() {
        addSubview(collectionView)
        addSubview(notiLabel)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        notiLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
}
