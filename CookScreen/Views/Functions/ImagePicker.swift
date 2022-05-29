//
//  ImagePicker.swift
//  CookScreen
//
//  Created by Blue Snow on 3/5/2565 BE.
//

import SwiftUI
import Combine

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var showImage : Bool
    @Binding var image : Data

    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
//        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child : ImagePicker
        
        init(child1: ImagePicker) {
            child = child1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.showImage.toggle()
        }
        func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image = info[.originalImage] as! UIImage
            
            let data = image.jpegData(compressionQuality: 1.0)
            
            self.child.image = data!
            self.child.showImage.toggle()
            
            print(self.child.image)
        }
    }
}

