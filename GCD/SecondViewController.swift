//
//  SecondViewController.swift
//  GCD
//
//  Created by Александр Касьянов on 24.11.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //свойства для загрузки изображений из интернета
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            //скрываем activity indicator
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        //вызываем alert controller с задержкой в три секунды
        delay(3) {
            self.loginAlert()
        }
    }
    
    //создаём функцию delay для отложенной загрузки
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    //создаём alert controller
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        //создаём кнопки
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        //добавляем кнопки в alert controller
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        //добавляем текстовые поля
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            //закрываем введённый пароль
            userPasswordTF.isSecureTextEntry = true
        }
        //отображаем alert controller
        self.present(ac, animated: true, completion: nil)
    }
    
    //метод для получения изображения
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        //включаем activity indicator
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        //создаём очередь
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            //проверяем, можем ли мы получить данные по url
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else {return}
            //асинхронно переходим в основной поток
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
}
