//
//  PersonViewController.swift
//  MoneyAccounting
//

import UIKit

final class PersonViewController: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var logOutButton: UIButton!
    
    private var person = Person.getPerson()
    
    private var infoUser: [String: String] {
        let name = Person.getPerson().firstName
        let surname = Person.getPerson().lastName
        let email = User.getUser().email
        let password = String(User.getUser().password.map { _ in "*" })
        
        return ["Имя": name, "Фамилия": surname, "Почта": email, "Пароль": password]
    }
    
    //MARK: Life Circle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationTittle()
        setupBarButtonItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        photoImageView.image = UIImage.tc
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
        logOutButton.backgroundColor = .systemBlue
        logOutButton.tintColor = .white
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 2

        
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
    
    
    @IBAction func logOutButtonAction() {
        if let navigationController = self.navigationController {
            // Возвращаемся на первый экран в стеке навигации
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
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

        if tableView.numberOfSections == 1 && tableView.numberOfRows(inSection: indexPath.section) == 4 {
            if indexPath.row == 0 {
                // Скругление верхних углов первой ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else if indexPath.row == 3 {
                // Скругление нижних углов последней ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else {
                maskLayer.path = UIBezierPath(rect: cell.bounds).cgPath
            }
            cell.layer.mask = maskLayer
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
    private func setupBarButtonItems() {
        // Back Button
        let arrowImage = UIImage(systemName: "chevron.backward")
        
        let backButton = UIButton(type: .system)
        backButton.setImage(arrowImage, for: .normal)
        backButton.setTitle("Назад", for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.tintColor = .systemBlue
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        // Edit Button
        let editButton = UIButton(type: .system)
        editButton.setTitle("Править", for: .normal)
        editButton.sizeToFit()
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        editButton.tintColor = .systemBlue
        
        let editBarButtonItem = UIBarButtonItem(customView: editButton)
        
        navigationItem.rightBarButtonItem = editBarButtonItem
    }

    func setupNavigationTittle() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationItem.hidesBackButton = false
        navigationItem.title = person.fullName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
      
    }
}
