//
//  AddNewAgendaViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import UIKit
import SnapKit
import RealmSwift
import Toast
import MapKit

class AddNewAgendaViewController: BaseViewController {
    
    var viewModel = AddNewAgendaViewModel()

    let mainView = AddNewAgendaView()
    override func loadView() {
        view.self = mainView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    let agendaRepository = TravelAgendaTableRepository()
    let locationRepository = LocationTableRepository()
    let toDoRepository = ToDoTableRepository()
    let costRepository = CostTableRepository()
    let linkRepository = LinkTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
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
        viewModel.dateList.bind { dateList in
            if !dateList.isEmpty {
                let result = self.viewModel.dateFormat(date: dateList[0])
                self.mainView.startDatetextField.text = result
                self.mainView.endDateLabel.text?.removeAll()
            }
            if dateList.count > 1 {
                let result = self.viewModel.dateFormat(date: dateList[1])
                self.mainView.endDateLabel.text = "-    \(result)"
            }
        }
        
        if viewModel.isUpdatingView {
            viewModel.placeName = viewModel.originalAgendaTable.placeName
            viewModel.latitude = viewModel.originalAgendaTable.latitude
            viewModel.longitude = viewModel.originalAgendaTable.longitude
            setMap()
        }

        mainView.collectionView.delegate = self
        mainView.datePickerView.addTarget(self, action: #selector(getDate(sender: )), for: .valueChanged)
        mainView.mapClickButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
        //agendaRepository.printRealmLocation()
        agendaRepository.checkSchemaVersion()
    }
    
    func setMap() {
        guard let name = viewModel.placeName else { return }
        guard let lat = viewModel.latitude else { return }
        guard let lon = viewModel.longitude else { return }
        
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mainView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mainView.mapView.addAnnotation(annotation)
    }
    
    @objc func mapButtonClicked() {
        let vc = MapViewController()
        vc.completionHandler = { name, lat, lon in
            self.viewModel.placeName = name
            self.viewModel.latitude = lat
            self.viewModel.longitude = lon
            
            self.setMap()
        }
        if let lat = viewModel.latitude {
            vc.viewModel.latitude.value = lat
        }
        if let lon = viewModel.longitude {
            vc.viewModel.longitude.value = lon
        }
        if let placeName = viewModel.placeName {
            vc.viewModel.placeName.value = placeName
        }
        present(vc, animated: true)
    }
    
    func setNavigationBar() {
        let archiveButton = UIBarButtonItem(image: UIImage(systemName: "archivebox"), style: .plain, target: self, action: #selector(archiveButtonClicked))
        
        let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        if viewModel.isUpdatingView {
            navigationItem.setRightBarButton(saveButton, animated: true)
        } else {
            navigationItem.setRightBarButtonItems([archiveButton, saveButton], animated: true)
        }
        
    }
    
    @objc func saveButtonClicked() {

        guard let startDate = viewModel.dateList.value.first else {
            let alert = UIAlertController(title: "여행 날짜를 설정해주세요", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        guard let endDate = viewModel.dateList.value.last else { return }
        let memo = viewModel.memoText.value
        
        if viewModel.isUpdatingView {
            updateOriginalTable(startDate: startDate, endDate: endDate, memo: memo)
        } else {
            addNewTable(startDate: startDate, endDate: endDate, memo: memo)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateOriginalTable(startDate: Date, endDate: Date, memo: String) {
        
        guard let name = viewModel.placeName else { return }
        guard let lat = viewModel.latitude else { return }
        guard let lon = viewModel.longitude else { return }
        
        agendaRepository.updateItem(id: viewModel.originalAgendaTable._id, title: viewModel.originalAgendaTable.title, startDate: startDate, endDate: endDate, memo: memo, numberOfImages: viewModel.originalAgendaTable.numberOfImages, placeName: name, latitude: lat, longitude: lon)
        
        let agendaID = viewModel.originalAgendaTable._id.stringValue
        
        toDoRepository.deleteItemFromID(agendaID)
        addToDoTable(agendaID: agendaID)
        
        costRepository.deleteItemFromID(agendaID)
        addCostTable(agendaID: agendaID)
        
        linkRepository.deleteItemFromID(agendaID)
        addLinkTable(agendaID: agendaID)
        
        locationRepository.updateItem(id: viewModel.originalAgendaTable._id.stringValue, placeName: name, latitude: lat, longitude: lon)
    }
    
    func addNewTable(startDate: Date, endDate: Date, memo: String) {
        viewModel.newTravelAgendaTable = TravelAgendaTable(title: navigationItem.title ?? "새 여행", startDate: startDate, endDate: endDate, memo: memo, numberOfImages: viewModel.savedImages.count, placeName: viewModel.placeName, latitude: viewModel.latitude, longitude: viewModel.longitude)
        
        agendaRepository.addItem(viewModel.newTravelAgendaTable)
        
        let id = viewModel.newTravelAgendaTable._id.stringValue
        
        makeFolder(folderName: id)
        saveImagesToDocument(folderName: id, images: viewModel.savedImages)
   
        addToDoTable(agendaID: id)
        addCostTable(agendaID: id)
        addLinkTable(agendaID: id)
        
        guard let lat = viewModel.latitude else { return }
        guard let lon = viewModel.longitude else { return }
        
        let item = LocationTable(id: id, placeName: viewModel.placeName ?? "", latitude: lat, longitude: lon)
        locationRepository.addItem(item)
        
    }
    
    func addToDoTable(agendaID: String) {
        let toDoList = viewModel.toDoList.value
        
        for todo in toDoList {
            let item = ToDoTable(agendaID: agendaID, toDo: todo)
            toDoRepository.addItem(item)
        }
    }
    
    func addCostTable(agendaID: String) {
        let costList = viewModel.costList.value
        
        for cost in costList {
            let item = CostTable(agendaID: agendaID, cost: cost)
            costRepository.addItem(item)
        }
    }
    
    func addLinkTable(agendaID: String) {
        let linkList = viewModel.linkList.value
        
        for link in linkList {
            let item = LinkTable(agendaID: agendaID, link: link)
            linkRepository.addItem(item)
        }
    }
    
    @objc func archiveButtonClicked() {
        let vc = AddPhotoViewController()
        vc.completionHandler = { images in
            self.viewModel.savedImages = images
        }
        vc.title = "사진 불러오기"
        vc.viewModel.isFromAddNewAgendaVC = true
        vc.viewModel.photoList.value = viewModel.savedImages
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func getDate(sender: UIDatePicker) {
        let date = sender.date
        
        // 1. 아예 처음 선택한 경우
        // 2. 두번째 잘 선택한 경우
        // 3. 첫번째보다 먼저 날짜의 두번째를 선택한 경우 -> 리셋
        // 4. 두개 이미 잘 들어가 있는데 다시 날짜 선택하는 경우
        
        if viewModel.dateList.value.isEmpty {
            viewModel.dateList.value.append(date)
        } else if viewModel.dateList.value.count == 1 && viewModel.dateList.value[0] < date {
            viewModel.dateList.value.append(date)
        } else if viewModel.dateList.value.count == 1 && viewModel.dateList.value[0] > date {
            viewModel.dateList.value[0] = date
        } else if viewModel.dateList.value.count > 1 {
            viewModel.dateList.value.removeAll()
            viewModel.dateList.value.append(date)
        }
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
            
            if indexPath.section != 0 {
                
                let deleteButton = UIButton()
                deleteButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
                deleteButton.tintColor = .red
                deleteButton.tag = indexPath.row
                
                switch indexPath.section {
                case 1:
                    deleteButton.addTarget(self, action: #selector(self.deleteTodoListButtonClicekd(sender: )), for: .touchUpInside)
                case 2:
                    deleteButton.addTarget(self, action: #selector(self.deleteCostListButtonClicked(sender: )), for: .touchUpInside)
                case 3:
                    deleteButton.addTarget(self, action: #selector(self.deleteLinkListButtonClicked(sender: )), for: .touchUpInside)
                default:
                    print(" 셀에서 삭제 버튼 클릭 오류 ")
                }
                
                cell.contentView.addSubview(deleteButton)
                deleteButton.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.trailing.equalToSuperview().inset(10)
                    make.size.equalTo(20)
                }
            }
            
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
                return headerView
            }
            
            return UICollectionReusableView()
        }
        
    }
    
    @objc func deleteTodoListButtonClicekd(sender: UIButton) {
        //print(sender.tag)
        viewModel.toDoList.value.remove(at: sender.tag)
    }
    
    @objc func deleteCostListButtonClicked(sender: UIButton) {
        viewModel.costList.value.remove(at: sender.tag)
    }
    
    @objc func deleteLinkListButtonClicked(sender: UIButton) {
        viewModel.linkList.value.remove(at: sender.tag)
    }
    
    @objc func addButtonClicked(sender: UIButton) {
        
        mainView.endEditing(true)
        
        if sender.tag == 0 {
            let vc = AddMemoViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.memoText = viewModel.memoText.value
            vc.completionHandler = { text in
                self.viewModel.memoText.value = text
            }
            present(vc, animated: true)
            return
        }
        
        let alert = UIAlertController(title: "새로운 항목을 추가하세요", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "새로운 항목 입력"
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                if text.isEmpty { return }
                
                if self.viewModel.toDoList.value.contains(text) || self.viewModel.costList.value.contains(text) || self.viewModel.linkList.value.contains(text) {
                    self.mainView.makeToast("이미 추가된 항목입니다.")
                    return
                }
                
                switch sender.tag {
                case 1 : self.viewModel.toDoList.value.append(text)
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

extension AddNewAgendaViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        mainView.endEditing(true)
    }
    
}

