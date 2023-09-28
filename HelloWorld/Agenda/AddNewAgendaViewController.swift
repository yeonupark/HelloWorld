//
//  AddNewAgendaViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import UIKit
import SnapKit

class AddNewAgendaViewController: BaseViewController {
    
    var viewModel = AddNewAgendaViewModel()

    var collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        
        viewModel.checkList.bind { _ in
            self.updateSnapshot() // 데이터 달라질 때 마다 컬렉션뷰 갱신 해줘
        }
        viewModel.memoList.bind { _ in
            self.updateSnapshot()
        }
        viewModel.costList.bind { _ in
            self.updateSnapshot()
        }
        viewModel.linkList.bind { _ in
            self.updateSnapshot()
        }

        collectionView.delegate = self
        
    }
    
    override func configure() {
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections([.CheckList, .MemoList, .CostList, .LinkList])
        
        snapshot.appendItems(viewModel.checkList.value, toSection: .CheckList)
        snapshot.appendItems(viewModel.memoList.value, toSection: .MemoList)
        snapshot.appendItems(viewModel.costList.value, toSection: .CostList)
        snapshot.appendItems(viewModel.linkList.value, toSection: .LinkList)
        
        dataSource.apply(snapshot)
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let sectionHeader = createSectionHeader()
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    static private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    
    private func configureDataSource() {
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            
            if indexPath.section == 0 {
                print(itemIdentifier)
                content.image = UIImage(systemName: "checkmark.square")
                content.imageProperties.tintColor = .systemPink
            }
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .white
            //backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
            
        })
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                
                let headerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
                headerView.backgroundColor = .systemPink
                
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                let label = UILabel()
                label.text = "\(section.rawValue)" // 섹션의 로우 값으로 헤더 텍스트 설정
                label.font = UIFont.boldSystemFont(ofSize: 17) // 원하는 폰트 및 스타일로 설정
                label.textColor = UIColor.white // 원하는 텍스트 색상으로 설정
                //label.translatesAutoresizingMaskIntoConstraints = false // 오토레이아웃 설정
                
                let addButton = UIButton()
                addButton.setImage(UIImage(systemName: "plus"), for: .normal)
                addButton.tag = indexPath.section
                addButton.tintColor = .white
                addButton.addTarget(self, action: #selector(self.addButtonClicked(sender: )), for: .touchUpInside)
                
                headerView.addSubview(label)
                headerView.addSubview(addButton)
                
                label.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(10)
                }
                addButton.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.size.equalTo(headerView.snp.height)
                }
                
                return headerView
            }
            
            return UICollectionReusableView()
        }
        
    }
    
    @objc func addButtonClicked(sender: UIButton) {
        
        let alert = UIAlertController(title: "새로운 항목을 추가하세요", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "새로운 항목 입력"
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                if text.isEmpty { return }
                
                switch sender.tag {
                case 0 : self.viewModel.checkList.value.append(text)
                case 1 : self.viewModel.memoList.value.append(text)
                case 2: self.viewModel.costList.value.append(text)
                case 3: self.viewModel.linkList.value.append(text)
                default: print("error")
                }
                self.updateSnapshot()
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
        
        
    }
    
}

extension AddNewAgendaViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let user = viewModel.list1.value[indexPath.item] 대신
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        dump(user) // print로 하나하나 요소 점 찍어서 가져오지 않아도 됨
        
    }
    
}
