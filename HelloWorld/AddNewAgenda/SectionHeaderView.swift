//
//  SectionHeaderView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/17.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView {
    
    let headerView = {
        let view = UICollectionReusableView()
        view.backgroundColor = Constant.Color.tableColor
        
        return view
    }()
    
    let headerLabel = {
        let view = UILabel()
        view.font = UIFont(name: Constant.FontName.regular, size: 16)! 
        view.textColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let addSectionButton = {
        let view = UIButton()
        //view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.tintColor = .white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerView)
        headerView.addSubview(headerLabel)
        headerView.addSubview(addSectionButton)
        
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        addSectionButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(headerView.snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
