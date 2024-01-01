//
//  MyTravelViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/27.
//

import UIKit

class MyTravelViewController: BaseViewController {
    
    let mainView = MyTravelView()
    
    override func loadView() {
        self.view = mainView
    }
    
    let viewModel = MyTravelViewModel()
    let agendaRepository = TravelAgendaTableRepository()
    let todoRepository = ToDoTableRepository()
    let costRepository = CostTableRepository()
    let linkRepository = LinkTableRepository()
    let locationRepository = LocationTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = (UIScreen.main.bounds.width - 16) / 1.5
        mainView.tableView.separatorColor = .clear
        
        viewModel.myTravelAgendas.bind { _ in
            self.mainView.tableView.reloadData()
        }
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.myTravelAgendas.value = agendaRepository.fetch()
    }
    
    func setNavigationItem() {
        navigationItem.title = NSLocalizedString("myTravel_title", comment: "")
    }
    
    @objc func addButtonClicked() {
        
        let alert = UIAlertController(title: NSLocalizedString("myTravel_alertTitle", comment: ""), message: NSLocalizedString("myTravel_alertMessage", comment: ""), preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = NSLocalizedString("myTravel_alertPlaceholder", comment: "")
        }
        let cancel = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel)
        let ok = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { _ in
            if let text = alert.textFields?.first?.text {
                if text.isEmpty { return }
                self.addNewAgenda(agendaTitle: text)
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func addNewAgenda(agendaTitle: String) {
        let vc = AddNewAgendaViewController()
        vc.title = agendaTitle
        vc.viewModel.isUpdatingView = false
        
        navigationItem.backButtonTitle = NSLocalizedString("cancel", comment: "")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyTravelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.myTravelAgendas.value.isEmpty ? 1 : viewModel.myTravelAgendas.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTravelTableViewCell", for: indexPath) as? MyTravelTableViewCell else { return UITableViewCell() }
        
        if viewModel.myTravelAgendas.value.isEmpty {
            cell.dateLabel.text?.removeAll()
            cell.titleLabel.text = NSLocalizedString("myTravel_emptyMessage", comment: "")
            cell.titleLabel.font = UIFont(name: Constant.FontName.regular, size: 18)
            return cell
        }
        
        let startDate = viewModel.dateFormat(date: viewModel.myTravelAgendas.value[indexPath.row].startDate)
        cell.dateLabel.text = startDate
        
        if viewModel.myTravelAgendas.value[indexPath.row].endDate != viewModel.myTravelAgendas.value[indexPath.row].startDate {
            let endDate = viewModel.dateFormat(date: viewModel.myTravelAgendas.value[indexPath.row].endDate)
            cell.dateLabel.text = "\(startDate) - \(endDate)"
        }
        
        cell.titleLabel.text = viewModel.myTravelAgendas.value[indexPath.row].title
        cell.titleLabel.font = UIFont(name: Constant.FontName.bold, size: 25)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.myTravelAgendas.value.isEmpty {
            addButtonClicked()
            return
        }
        
        let table = viewModel.myTravelAgendas.value[indexPath.item]
        let vc = ShowAgendaViewController()
        
        vc.title = table.title
        vc.viewModel.travelAgendaTable = table
        vc.viewModel.savedImages = loadImageFromDocument(folderName: table._id.stringValue, numberOfImages: table.numberOfImages)
        
        navigationItem.backButtonTitle = NSLocalizedString("myTravel_title", comment: "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.myTravelAgendas.value.isEmpty ? false : true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            deleteButtonClicked(indexPath: indexPath)
        }
    }
    
    func deleteButtonClicked(indexPath: IndexPath) {
        
        let id = viewModel.myTravelAgendas.value[indexPath.row]._id.stringValue
        let numberOfImages = viewModel.myTravelAgendas.value[indexPath.row].numberOfImages
        let agendaTable = self.viewModel.myTravelAgendas.value[indexPath.row]
        
        let alert = UIAlertController(title: NSLocalizedString("myTravel_deleteTitle", comment: ""), message: NSLocalizedString("myTravel_deleteMessage", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel)
        let ok = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { _ in
            
            self.removeImagesFromDocument(folderName: id, numberOfImages: numberOfImages)
            self.removeFolder(folderName: id)
            self.agendaRepository.deleteItem(agendaTable)
            self.todoRepository.deleteItemFromID(id)
            self.costRepository.deleteItemFromID(id)
            self.linkRepository.deleteItemFromID(id)
            self.locationRepository.deleteItemFromID(id)
            
            self.viewModel.myTravelAgendas.value = self.agendaRepository.fetch()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
        
    }
    
}
