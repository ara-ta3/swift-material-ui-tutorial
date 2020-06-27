import UIKit

class LoginViewController: UIViewController {
  let scrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    return view
  }()

  let logo: UIImageView = {
    let baseImage = UIImage.init(named: "ShrineLogo")
    let image = baseImage?.withRenderingMode(.alwaysTemplate)
    let logoImageView = UIImageView(image: image)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    return logoImageView
  }()

  let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = "SHRINE"
    titleLabel.sizeToFit()
    return titleLabel
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.tintColor = .black
    scrollView.backgroundColor = .white

    view.addSubview(scrollView)

    NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
                    options: [],
                    metrics: nil,
                    views: ["scrollView" : scrollView])
    )
    NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                    options: [],
                    metrics: nil,
                    views: ["scrollView" : scrollView])
    )
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapTouch))
    scrollView.addGestureRecognizer(tapGestureRecognizer)

    scrollView.addSubview(titleLabel)
    scrollView.addSubview(logo)

    // TextFields
    //TODO: Add text fields to scroll view and setup initial state
    // Buttons
    //TODO: Add buttons to the scroll view
    // Constraints
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: logo,
            attribute: .top,
            relatedBy: .equal,
            toItem: scrollView.contentLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 49))
    constraints.append(NSLayoutConstraint(item: logo,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
    constraints.append(NSLayoutConstraint(item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: logo,
            attribute: .bottom,
            multiplier: 1,
            constant: 22))
    constraints.append(NSLayoutConstraint(item: titleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
    // Text Fields
    //TODO: Setup text field constraints
    // Buttons
    //TODO: Setup button constraints
    NSLayoutConstraint.activate(constraints)
  }

  // MARK: - Gesture Handling
  @objc func didTapTouch(sender: UIGestureRecognizer) {
    view.endEditing(true)
  }

  func registerKeyboardNotifications() {
    NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"),
            object: nil)
    NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: NSNotification.Name(rawValue: "UIKeyboardWillChangeFrameNotification"),
            object: nil)
    NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"),
            object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    let keyboardFrame =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0);
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    self.scrollView.contentInset = UIEdgeInsets.zero;
  }
}

extension LoginViewController: UITextFieldDelegate {
}