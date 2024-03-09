//
//  PersonViewController.swift
//  MoneyAccounting
//

import UIKit

final class PersonViewController: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var logOutButton: UIButton!
    
    private var infoUser: [String: String] {
        let name = Person.getPerson().firstName
        let surname = Person.getPerson().lastName
        let email = User.getUser().email
        let password = String(User.getUser().password.map { _ in "*" })
        
        return ["Имя": name, "Фамилия": surname, "Почта": email, "Пароль": password]
    }
    
    //MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        photoImageView.image = UIImage.tc
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
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

extension PersonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        let positions = ["Имя", "Фамилия", "Почта", "Пароль"]
        let target = infoUser[positions[indexPath.row]]
        
        var content = cell.defaultContentConfiguration()
        content.text = positions[indexPath.row]
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        
        content.secondaryText = target
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 18)
        content.secondaryTextProperties.color = .black
        
        cell.contentConfiguration = content
        cell.contentView.backgroundColor = UIColor(hex: "#F9F9FC")
        
        let cornerRadius: CGFloat = 10
        let maskLayer = CAShapeLayer()
        
        if tableView.numberOfRows(inSection: indexPath.section) == 1 {
            // Если в секции только одна ячейка, скругляем все углы
            let bounds = cell.bounds
            let rectPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            maskLayer.path = rectPath.cgPath
        } else {
            if indexPath.row == 0 {
                // Скругление верхних углов первой ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // Скругление нижних углов последней ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else {
                // Для остальных ячеек не применяем скругление углов
                maskLayer.path = UIBezierPath(rect: cell.bounds).cgPath
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
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
