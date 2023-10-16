//
//  AddPhotoViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/02.
//

import UIKit
import Photos
import PhotosUI

class AddPhotoViewController: BaseViewController {
    
    let mainView = AddNewPhotoView()
    
    override func loadView() {
        view.self = mainView
    }
    
    let viewModel = AddNewPhotoViewModel()
    var completionHandler: (([UIImage]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        viewModel.photoList.bind { _ in
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
        viewModel.isEditable.bind { _ in
            self.mainView.collectionView.reloadData()
        }
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !viewModel.isFromAddNewAgendaVC {
            return
        }
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        if status == .authorized {
            showImagePicker()
        } else if status == .denied || status == .restricted {
            showDeniedAlert()
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self.showImagePicker()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showDeniedAlert()
                    }
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if viewModel.isFromAddNewAgendaVC {
            completionHandler?(viewModel.photoList.value)
        }
    }
    
    func setNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(addButtonClicked))
        addButton.isHidden = true
        let editButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editButtonClicked(sender: )))
        
        navigationItem.setRightBarButtonItems([editButton, addButton], animated: true)
        
    }
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {
        if viewModel.isEditable.value {
            saveImages()
            sender.title = "edit"
            viewModel.isEditable.value = false
            navigationItem.rightBarButtonItems![1].isHidden = true
        } else {
            sender.title = "done"
            viewModel.isEditable.value = true
            navigationItem.rightBarButtonItems![1].isHidden = false
        }
    }
    
    func saveImages() {
        guard let id = viewModel.tableID else { return }
        
        removeImagesFromDocument(folderName: id, numberOfImages: viewModel.originalNumberOfPhotos)
        saveImagesToDocument(folderName: "\(id)", images: viewModel.photoList.value)
        completionHandler?(viewModel.photoList.value)
    }
    
    @objc func addButtonClicked() {
        //showImagePicker()
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        if status == .authorized {
            showImagePicker()
        } else if status == .denied || status == .restricted {
            showDeniedAlert()
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self.showImagePicker()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showDeniedAlert()
                    }
                }
            }
        }
    }
    
    func showDeniedAlert() {
        let alert = UIAlertController(title: "갤러리에 접근할 수 없습니다.", message: "기기의 '설정>개인정보 보호'에서 갤러리 접근 권한을 허용해주세요.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let goToSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSetting)
            }
        }
        alert.addAction(cancel)
        alert.addAction(goToSetting)
        present(alert, animated: true)
    }
    
    func showImagePicker() {
        
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 50
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        
        present(picker, animated: true)
    }
}

extension AddPhotoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        self.viewModel.photoList.value.append(image)
                    }
                }
            }
        }
    }
}

extension AddPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = viewModel.photoList.value[indexPath.item]
        cell.deleteButton.isHidden = !viewModel.isEditable.value
        
        if viewModel.isEditable.value {
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender: )), for: .touchUpInside)
        }
        return cell
    }
    
    @objc func deleteButtonClicked(sender: UIButton) {
        let index = sender.tag
        viewModel.photoList.value.remove(at: index)
        
        if !viewModel.isFromAddNewAgendaVC {
            
        }
    }
}
