//
//  AddNewAgendaCollectionViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import UIKit
import SnapKit

class AddNewAgendaCollectionViewController: BaseViewController {
    
    enum Section: String, CaseIterable {
        case CheckList = "체크리스트"
        case MemoList = "메모"
        case CostList = "예상 비용"
        case LinkList = "링크"
    }
    
    var viewModel = AddNewAgendaViewModel()

    var collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        
        //updateSnapshot()
        
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
        
        viewModel.list1.bind { user in
            self.updateSnapshot() // 데이터 달라질 때 마다 컬렉션뷰 갱신 해줘
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.viewModel.append()
//            //self.list1.insert(User(name: "연준", age: 23), at: 2)
//            self.updateSnapshot()
//        }
        
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

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0)) // 아이템 높이에 따라 그룹 높이 설정
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        
        let sectionHeader = createSectionHeader()
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        //var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        //configuration.showsSeparators = true
        //configuration.backgroundColor = .black
        //let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    static private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    
    private func configureDataSource() {
        
        // UICollectionView.CellRegistration -> iOS 14 이상, 메서드 대신 제네릭을 사용, 셀이 생성될 때마다 클로저가 호출됨 !
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, itemIdentifier in
            
            // 셀 디자인 및 데이터 처리
            //var content = cell.defaultContentConfiguration()
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            //content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star")
            content.imageProperties.tintColor = .systemPink
            // content.prefersSideBySideTextAndSecondaryText = false
            //content.textToSecondaryTextVerticalPadding = 10
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
            
        })
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            // cellForItamAt
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                
                let headerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)

                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                let label = UILabel()
                label.text = "\(section.rawValue)" // 섹션의 로우 값으로 헤더 텍스트 설정
                print(section.rawValue)
                label.font = UIFont.boldSystemFont(ofSize: 17) // 원하는 폰트 및 스타일로 설정
                label.textColor = UIColor.black // 원하는 텍스트 색상으로 설정
                //label.translatesAutoresizingMaskIntoConstraints = false // 오토레이아웃 설정
                
                headerView.addSubview(label)
                
                label.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(10)
                }
                
                return headerView
            }
            
            return UICollectionReusableView()
        }
        
    }
    
}

extension AddNewAgendaCollectionViewController: UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let user = viewModel.list1.value[indexPath.item] 대신
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        dump(user) // print로 하나하나 요소 점 찍어서 가져오지 않아도 됨
        self.viewModel.removeUser(idx: indexPath.item)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text ?? "짱구")
    }
}
