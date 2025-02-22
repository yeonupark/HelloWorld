//
//  AddNewAgendaView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/30.
//

import UIKit
import MapKit

class AddNewAgendaView: BaseView {
    
    let startDatetextField = {
        let view = UITextField()
        view.placeholder = NSLocalizedString("date_placeholder", comment: "")
        view.font = UIFont(name: Constant.FontName.regular, size: 15)
        view.textColor = Constant.Color.titleColor
        
        view.tintColor = .clear
        return view
    }()
    
    let endDateLabel = {
        let view = UILabel()
        view.font = UIFont(name: Constant.FontName.regular, size: 15)
        
        return view
    }()
    
    let datePickerView = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        view.isMultipleTouchEnabled = true
        
        return view
    }()
    
    let mapView = {
        let view = MKMapView()
        
        return view
    }()
    
    let mapClickButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "hand.tap.fill"), for: .normal)
        view.tintColor = .black
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        
        return view
    }()
    
    var collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createLayout())
    
    static private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let sectionHeader = createSectionHeader()
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    static private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    
    override func configure() {
        startDatetextField.inputView = datePickerView
        addSubview(startDatetextField)
        addSubview(endDateLabel)
        addSubview(mapView)
        addSubview(collectionView)
        mapView.addSubview(mapClickButton)
    }
    
    override func setConstraints() {
        startDatetextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(startDatetextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(startDatetextField.snp.bottom)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        mapClickButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
    }
}
