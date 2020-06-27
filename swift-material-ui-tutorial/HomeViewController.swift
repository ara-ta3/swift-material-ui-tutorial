import UIKit

class HomeViewController: UIViewController {
  var shouldDisplayLogin = true

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.tintColor = .black
    self.view.backgroundColor = .white

    self.title = "Shrine"

    // Done Label
    let doneLabel = UILabel()
    doneLabel.translatesAutoresizingMaskIntoConstraints = false
    doneLabel.text = "You did it!"
    self.view.addSubview(doneLabel)
    doneLabel.sizeToFit()

    NSLayoutConstraint(item: doneLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: doneLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if (self.shouldDisplayLogin) {
      let loginViewController = LoginViewController(nibName: nil, bundle: nil)
      self.present(loginViewController, animated: false, completion: nil)
      self.shouldDisplayLogin = false
    }
  }

}
