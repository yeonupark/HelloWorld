//
//  FileManager.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/07.
//

import UIKit

extension UIViewController {
    
    func saveImagesToDocument(fileName: String, images: [UIImage]) {
        
        if images.isEmpty { return }
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        for i in 0...images.count - 1 {
            
            let fileURL = documentDirectory.appendingPathComponent("\(fileName)\(i)")
            
            guard let data = images[i].jpegData(compressionQuality: 0.5) else { return }
            
            do {
                try data.write(to: fileURL)
            } catch let error {
                print("이미지 파일 저장 중 오류 발생 ", error)
            }
        }
    }
    
    func loadImageFromDocument(fileName: String, numberOfImages: Int) -> [UIImage] {
        
        if numberOfImages == 0 { return [] }

        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
        
        var list: [UIImage] = []
        
        for i in 0...numberOfImages - 1 {
            
            let fileURL = documentDirectory.appendingPathComponent("\(fileName)\(i)")
     
            if FileManager.default.fileExists(atPath: fileURL.path) {
                list.append(UIImage(contentsOfFile: fileURL.path)!)
            } else {
                list.append(UIImage(systemName: "star")!)
            }
            
        }
        
        return list
    }
    
    func removeImagesFromDocument(fileName: String, numberOfImages: Int) {
        
        if numberOfImages == 0 { return }
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        for i in 0...numberOfImages - 1 {
            
            let fileURL = documentDirectory.appendingPathComponent("\(fileName)\(i)")

            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch let error {
                print("이미지 파일 삭제 중 오류 발생 ", error)
            }
            
        }
        
    }
}
