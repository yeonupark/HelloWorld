//
//  ShowAgendaViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/08.
//

import UIKit
import MapKit

class ShowAgendaViewController: BaseViewController {
    
    let mainView = AddNewAgendaView()
    override func loadView() {
        view.self = mainView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    let viewModel = ShowAgendaViewModel()
    let repository = TravelAgendaTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        configureDataSource()
        
        mainView.collectionView.delegate = self
        mainView.startDatetextField.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAllData()
        showDate()
        setMap()
        
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
    }
    
    func setMap() {
        guard let name = viewModel.travelAgendaTable.placeName else { return }
        guard let lat = viewModel.travelAgendaTable.latitude else { return }
        guard let lon = viewModel.travelAgendaTable.longitude else { return }
        
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mainView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mainView.mapView.addAnnotation(annotation)
    }
    
    func showDate() {
        
        guard let startDate = viewModel.dateList.value.first else { return }
        mainView.startDatetextField.text = viewModel.dateFormat(date: startDate)
        guard let endDate = viewModel.dateList.value.last else { return }
        
        if endDate != startDate {
            mainView.endDateLabel.text = "-    \(viewModel.dateFormat(date: endDate))"
        }
    }
    
    func fetchAllData() {
        
        if let memo = viewModel.travelAgendaTable.memo {
            viewModel.memoText.value = memo
        }
        viewModel.toDoList.value = fetchTodoList()
        viewModel.costList.value = fetchCostList()
        viewModel.linkList.value = fetchLinkList()
        viewModel.dateList.value.append(viewModel.travelAgendaTable.startDate)
        viewModel.dateList.value.append(viewModel.travelAgendaTable.endDate)
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
        
        let editButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editButtonClicked(sender: )))
        
        navigationItem.setRightBarButtonItems([archiveButton, editButton], animated: true)
    }
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {

        navigationItem.backButtonTitle = "취소"
        
        let vc = AddNewAgendaViewController()
        vc.title = "수정하기"
        vc.viewModel.isUpdatingView = true
        
        vc.viewModel.dateList = viewModel.dateList
        vc.viewModel.memoText = viewModel.memoText
        vc.viewModel.toDoList = viewModel.toDoList
        vc.viewModel.costList = viewModel.costList
        vc.viewModel.linkList = viewModel.linkList
        
        vc.viewModel.originalAgendaTable = viewModel.travelAgendaTable
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func archiveButtonClicked() {
        let vc = AddPhotoViewController()
        vc.title = "저장된 사진"
        navigationItem.backButtonTitle = "저장"
        vc.completionHandler = { images in
            self.viewModel.savedImages = images
        }
        
        vc.viewModel.photoList.value = viewModel.savedImages
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
            
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                
                let headerView = self.mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
                headerView.backgroundColor = UIColor(named: "Orange")
                
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                let label = UILabel()
                label.text = "\(section.rawValue)"
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.textColor = UIColor.white
                //label.translatesAutoresizingMaskIntoConstraints = false
                
                headerView.addSubview(label)
                label.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(10)
                }
                
                return headerView
            }
            
            return UICollectionReusableView()
        }
        
    }
    
    @objc func deleteTodoListButtonClicekd(sender: UIButton) {
        print(sender.tag)
        viewModel.toDoList.value.remove(at: sender.tag)
    }
    
    @objc func deleteCostListButtonClicked(sender: UIButton) {
        viewModel.costList.value.remove(at: sender.tag)
    }
    
    @objc func deleteLinkListButtonClicked(sender: UIButton) {
        viewModel.linkList.value.remove(at: sender.tag)
    }
    
}

extension ShowAgendaViewController: UICollectionViewDelegate {
    
}
