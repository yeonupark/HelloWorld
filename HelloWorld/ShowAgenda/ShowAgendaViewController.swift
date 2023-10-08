//
//  ShowAgendaViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/08.
//

import UIKit

class ShowAgendaViewController: BaseViewController {
    
    let mainView = AddNewAgendaView()
    override func loadView() {
        view.self = mainView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    let viewModel = ShowAgendaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        showDate()
        fetchAllData()
        
        configureDataSource()
        
        viewModel.toDoList.bind { _ in
            self.updateSnapshot()
        }
        viewModel.memoText.bind { _ in
            self.updateSnapshot()
        }
        viewModel.costList.bind { _ in
            self.updateSnapshot()
        }
        viewModel.linkList.bind { _ in
            self.updateSnapshot()
        }
        
        mainView.collectionView.delegate = self
        
    }
    
    func showDate() {
        
        let startDate = viewModel.travelAgendaTable.startDate
        mainView.startDatetextField.text = viewModel.dateFormat(date: startDate)
        
        if viewModel.travelAgendaTable.endDate != viewModel.travelAgendaTable.startDate {
            let endDate = viewModel.dateFormat(date: viewModel.travelAgendaTable.endDate)
            mainView.endDateLabel.text = "-    \(endDate)"
        }
    }
    
    func fetchAllData() {
        
        if let memo = viewModel.travelAgendaTable.memo {
            viewModel.memoText.value = memo
        }
        viewModel.toDoList.value = fetchTodoList()
        viewModel.costList.value = fetchCostList()
        viewModel.linkList.value = fetchLinkList()
    }
    
    func fetchTodoList() -> [String] {
        let objectList = viewModel.travelAgendaTable.toDoList
        var stringList: [String] = []
        for item in objectList {
            let data = item.toDo
            stringList.append(data)
        }
        
        return stringList
    }
    
    func fetchCostList() -> [String] {
        let objectList = viewModel.travelAgendaTable.costList
        var stringList: [String] = []
        for item in objectList {
            let data = item.cost
            stringList.append(data)
        }
        
        return stringList
    }
    
    func fetchLinkList() -> [String] {
        let objectList = viewModel.travelAgendaTable.linkList
        var stringList: [String] = []
        for item in objectList {
            let data = item.link
            stringList.append(data)
        }
        
        return stringList
    }
    
    func setNavigationBar() {
        let archiveButton = UIBarButtonItem(image: UIImage(systemName: "archivebox"), style: .plain, target: self, action: #selector(archiveButtonClicked))
        
        let editButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editButtonClicked))
        
        navigationItem.setRightBarButtonItems([archiveButton, editButton], animated: true)
    }
    
    @objc func editButtonClicked() {
        
    }
    
    @objc func archiveButtonClicked() {
        let vc = AddPhotoViewController()
        vc.title = "저장된 사진"
        
        vc.viewModel.photoList.value = loadImageFromDocument(fileName: viewModel.travelAgendaTable._id.stringValue, numberOfImages: viewModel.travelAgendaTable.numberOfImages)
        vc.viewModel.isFromAddNewAgendaVC = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections([.MemoText, .ToDoList, .CostList, .LinkList])
        
        snapshot.appendItems(viewModel.toDoList.value, toSection: .ToDoList)
        if viewModel.memoText.value == "" {
            snapshot.appendItems([], toSection: .MemoText)
        } else {
            snapshot.appendItems([viewModel.memoText.value], toSection: .MemoText)
        }
        snapshot.appendItems(viewModel.costList.value, toSection: .CostList)
        snapshot.appendItems(viewModel.linkList.value, toSection: .LinkList)
        
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        
        mainView.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()

            content.text = itemIdentifier
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            if indexPath.section == 1 {
                content.image = UIImage(systemName: "checkmark.square")
                content.imageProperties.tintColor = UIColor(named: "Orange")
            }
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .white
            //backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            backgroundConfig.strokeColor = UIColor(named: "Orange")
            cell.backgroundConfiguration = backgroundConfig
            
            
        })
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
//            if indexPath.section != 0 {
//                
//                let deleteButton = UIButton()
//                deleteButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
//                deleteButton.tintColor = .red
//                deleteButton.tag = indexPath.row
//                
//                switch indexPath.section {
//                case 1:
//                    deleteButton.addTarget(self, action: #selector(self.deleteTodoListButtonClicekd(sender: )), for: .touchUpInside)
//                case 2:
//                    deleteButton.addTarget(self, action: #selector(self.deleteCostListButtonClicked(sender: )), for: .touchUpInside)
//                case 3:
//                    deleteButton.addTarget(self, action: #selector(self.deleteLinkListButtonClicked(sender: )), for: .touchUpInside)
//                default:
//                    print(" 셀에서 삭제 버튼 클릭 오류 ")
//                }
//                
//                cell.contentView.addSubview(deleteButton)
//                deleteButton.snp.makeConstraints { make in
//                    make.top.bottom.equalToSuperview()
//                    make.trailing.equalToSuperview().inset(10)
//                    make.size.equalTo(20)
//                }
//            }
            
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                
                let headerView = self.mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
                headerView.backgroundColor = UIColor(named: "Orange")
                
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                let label = UILabel()
                print("오예",section.rawValue)
                label.text = "\(section.rawValue)"
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.textColor = UIColor.white
                //label.translatesAutoresizingMaskIntoConstraints = false
                
                headerView.addSubview(label)
                label.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(10)
                }
                
                /*
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
                if indexPath.section == 0 {
                    addButton.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
                }
                 */
                return headerView
            }
            
            return UICollectionReusableView()
        }
        
    }
    
}

extension ShowAgendaViewController: UICollectionViewDelegate {
    
}
