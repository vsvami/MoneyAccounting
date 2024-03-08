//
//  PersonViewController.swift
//  MoneyAccounting
//

import UIKit

final class PersonViewController: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var logOutButton: UIButton!
    
    @IBOutlet var grayView: UIView!
    
    //MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        photoImageView.image = UIImage.tc
        
        grayView.layer.cornerRadius = 15
        
        logOutButton.backgroundColor = .systemBlue
        logOutButton.tintColor = .white
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 2
    }
    
    
    //MARK: - IB Actions
    @IBAction func addPhotoAction() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
}

//MARK: Work with image
extension PersonViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.editedImage] as? UIImage
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.clipsToBounds = true
        
        dismiss(animated: true)
    }
}

