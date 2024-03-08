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
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
        grayView.layer.cornerRadius = 15
        
        logOutButton.backgroundColor = .systemBlue
        logOutButton.tintColor = .white
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 2
        
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Восстановление стандартного цвета и предыдущих настроек navigationBar
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    //MARK: - Public Methods
    @objc func editButtonTapped() {
        let storyboard = UIStoryboard(name: "EditPerson", bundle: nil)
        let editPersonVC = storyboard.instantiateViewController(withIdentifier: "EditPersonViewController") as! EditPersonViewController
        navigationController?.pushViewController(editPersonVC, animated: true)
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

//MARK: - NavigationBar
extension PersonViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.tintColor = .systemBlue
        
        navigationItem.hidesBackButton = false
        
        navigationItem.title = "Tim Cook"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
}
