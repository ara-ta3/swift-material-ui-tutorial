import UIKit
import MaterialComponents

/**
 * @see https://github.com/material-components/material-components-ios-codelabs
 */
class LoginViewController: UIViewController {
  let scrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    return view
  }()

  let logo: UIImageView = {
    let baseImage = UIImage.init(named: "Shrine")
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

  let usernameTextField: MDCTextField = {
    let usernameTextField = MDCTextField()
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.clearButtonMode = .unlessEditing
    usernameTextField.backgroundColor = .white
    return usernameTextField
  }()

  let passwordTextField: MDCTextField = {
    let passwordTextField = MDCTextField()
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.isSecureTextEntry = true
    passwordTextField.backgroundColor = .white
    return passwordTextField
  }()
  let usernameTextFieldController: MDCTextInputControllerOutlined
  let passwordTextFieldController: MDCTextInputControllerOutlined

  let cancelButton: MDCButton = {
    let cancelButton = MDCButton()
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.setTitle("CANCEL", for: .normal)
    cancelButton.addTarget(self, action: #selector(didTapCancel(sender:)), for: .touchUpInside)
    return cancelButton
  }()
  let nextButton: MDCButton = {
    let nextButton = MDCButton()
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    nextButton.setTitle("NEXT", for: .normal)
    nextButton.addTarget(self, action: #selector(didTapNext(sender:)), for: .touchUpInside)
    return nextButton
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    usernameTextFieldController = MDCTextInputControllerOutlined(textInput: usernameTextField)
    passwordTextFieldController = MDCTextInputControllerOutlined(textInput: passwordTextField)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let colorScheme = ApplicationScheme.shared.colorScheme
    self.view.tintColor = colorScheme.onSurfaceColor
    self.view.backgroundColor = colorScheme.surfaceColor
    self.logo.tintColor = colorScheme.onSurfaceColor
    self.titleLabel.textColor = colorScheme.onSurfaceColor
    MDCButtonColorThemer.applySemanticColorScheme(colorScheme,
            to: self.cancelButton)
    MDCButtonColorThemer.applySemanticColorScheme(colorScheme,
            to: self.nextButton)

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
    scrollView.addSubview(usernameTextField)
    scrollView.addSubview(passwordTextField)
    scrollView.addSubview(nextButton)
    scrollView.addSubview(cancelButton)

    usernameTextFieldController.placeholderText = "Username"
    usernameTextField.delegate = self
    passwordTextFieldController.placeholderText = "Password"
    passwordTextField.delegate = self
    registerKeyboardNotifications()

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
    constraints.append(NSLayoutConstraint(item: usernameTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 22))
    constraints.append(NSLayoutConstraint(item: usernameTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
    constraints.append(contentsOf:
    NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-|",
            options: [],
            metrics: nil,
            views: [ "username" : usernameTextField]))
    constraints.append(NSLayoutConstraint(item: passwordTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: usernameTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 8))
    constraints.append(NSLayoutConstraint(item: passwordTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
    constraints.append(contentsOf:
    NSLayoutConstraint.constraints(withVisualFormat: "H:|-[password]-|",
            options: [],
            metrics: nil,
            views: [ "password" : passwordTextField]))
    constraints.append(NSLayoutConstraint(item: cancelButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: passwordTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 8))
    constraints.append(NSLayoutConstraint(item: cancelButton,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: nextButton,
            attribute: .centerY,
            multiplier: 1,
            constant: 0))
    constraints.append(contentsOf:
    NSLayoutConstraint.constraints(withVisualFormat: "H:[cancel]-[next]-|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: [ "cancel" : cancelButton, "next" : nextButton]))
    constraints.append(NSLayoutConstraint(item: nextButton,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: scrollView.contentLayoutGuide,
            attribute: .bottomMargin,
            multiplier: 1,
            constant: -20))

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

  @objc func didTapNext(sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  @objc func didTapCancel(sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder();

    // TextField
    if (textField == passwordTextField) {
      let textFieldCharacterCount = textField.text?.count ?? 0
      if (textFieldCharacterCount < 8) {
        passwordTextFieldController.setErrorText("Password is too short",
                errorAccessibilityValue: nil)
      } else {
        passwordTextFieldController.setErrorText(nil, errorAccessibilityValue:nil)
      }
    }

    return false
  }
}