//
//  PhotoCollectionViewCell.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/02.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    let deleteButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        view.tintColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(50)
        }
    }
}
