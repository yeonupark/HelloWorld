//
//  FileManager.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/07.
//

import UIKit

extension UIViewController {
    
    func makeFolder(folderName: String) {
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let directoryURL = documentURL?.appendingPathComponent(folderName) else { return }
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: false, attributes: nil)
        } catch let error {
            print(error)
        }
    }
    
    func saveImagesToDocument(folderName: String, images: [UIImage]) {
        
        if images.isEmpty { return }
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let folderURL = documentDirectory.appendingPathComponent(folderName)
        
        for i in 0..<images.count {
            
            let fileName = "\(folderName)\(i).jpg"
            let fileURL = folderURL.appendingPathComponent(fileName)
            
            guard let data = images[i].jpegData(compressionQuality: 0.5) else { return }
            
            do {
                try data.write(to: fileURL)
            } catch let error {
                print("이미지 파일 저장 중 오류 발생 ", error)
            }
        }
    }
    
    func loadImageFromDocument(folderName: String, numberOfImages: Int) -> [UIImage] {
        
        if numberOfImages == 0 { return [] }

        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
        
        var list: [UIImage] = []
        
        for i in 0..<numberOfImages {
            
            let fileName = "\(folderName)\(i).jpg"
            let fileURL = documentDirectory.appendingPathComponent(folderName).appendingPathComponent(fileName)
     
            if FileManager.default.fileExists(atPath: fileURL.path) {
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    list.append(image)
                } else {
                    list.append(UIImage(systemName: "exclamationmark.triangle")!)
                }
            } else {
                list.append(UIImage(systemName: "exclamationmark.triangle")!)
            }
        }
        return list
    }
    
    func removeImagesFromDocument(folderName: String, numberOfImages: Int) {
        
        if numberOfImages == 0 { return }
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        for i in 0..<numberOfImages {
            let fileName = "\(folderName)\(i).jpg"
            let fileURL = documentDirectory.appendingPathComponent(folderName).appendingPathComponent(fileName)

            do {
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    try FileManager.default.removeItem(at: fileURL)
                }
            } catch let error {
                print("이미지 파일 삭제 중 오류 발생 ", error)
            }
        }
    }
    
    func removeFolder(folderName: String) {
        let fileManager = FileManager.default
        
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let folderURL = documentDirectory.appendingPathComponent(folderName)
        
        do {
            try fileManager.removeItem(at: folderURL)
        } catch let error {
            print("폴더 삭제 중 오류 발생: \(error)")
        }
    }
}
