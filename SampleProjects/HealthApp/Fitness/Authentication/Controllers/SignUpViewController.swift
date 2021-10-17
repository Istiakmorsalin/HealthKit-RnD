
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.tintColor = UIColor.lightGray
            emailTextField.setIcon(UIImage(named: "Email")!)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tintColor = UIColor.lightGray
            passwordTextField.setIcon(UIImage(named: "Password")!)
        }
    }
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var continueWithFacebook: UIButton!
    @IBOutlet weak var continueWithTwitter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAccountButton.layer.cornerRadius = 12
        continueWithTwitter.layer.cornerRadius = 12
        continueWithFacebook.layer.cornerRadius = 12
        
//        continueWithTwitter.setImage(UIImage(named: "Twitter"), for: .normal)
//        continueWithFacebook.setImage(UIImage(named: "Facebook"), for: .normal)
        
        self.hideKeyboardWhenTappedAround()
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "Create Account" {
                if let destinationViewController = segue.destination as? CreateAccountViewController {
                    destinationViewController.modalPresentationStyle = .fullScreen
                }
            }
        }
    }
    
    // TIME: Working on Sun 29
    // TODO: Verify the existing of the email address
    //       Before to perform segue towards the information pages.
    @IBAction func createAccount(_ sender: UIButton) {
        
        if let email = emailTextField.text, !email.isEmpty {
            
            /// TODO: Verify if no user has already this email address.
            /// TODO: Verify if the lenght of the password is greater than 8
                        
            let verifyExistingEmailPath = API.shared.verifyExistingPath
            
            let session = URLSession.shared
            
            let url = URL(string: verifyExistingEmailPath)!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if isValidEmail(email: email) {
                
                let emailArray = ["email": email]
                
                let emailJSON = try! JSONSerialization.data(withJSONObject: emailArray, options: [])
                
                DispatchQueue.global(qos: .background).async {
                    
                    let task = session.uploadTask(with: request, from: emailJSON) { data, response, error in
                        
                        if let data = data {
                            
                            do {
                                
                                let serverResponse = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String:Any]
                                
                                if serverResponse != nil, serverResponse?.keys.contains("message") ?? false {
                                    
                                    // Use a direct method that convert String into Bool
                                    let isExiting = serverResponse?["message"] as? String
                                    
                                    // User exists already
                                    if isExiting == "True" {
                                        
                                        DispatchQueue.main.async {
                                            // TODO: Display error message
                                        }
                                    
                                    } else {
                                        
                                        DispatchQueue.main.async {
                                            
                                            if let password = self.passwordTextField.text, !password.isEmpty {
                                                
                                                let authStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
                                                
                                                let initialViewController = authStoryboard.instantiateViewController(identifier: "Create Account") as CreateAccountViewController

                                                initialViewController.modalPresentationStyle = .fullScreen
                                                initialViewController.email = email
                                                initialViewController.password = password
                                                
                                                self.present(initialViewController, animated: true, completion: nil)
                                                
                                            }
                                        }
                                        
                                    }

                                }
                                
                            } catch let error as NSError {
                                print(error)
                            }
                            
                        }
                    }
                    
                    task.resume()
                }
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            if let password = passwordTextField.text, !password.isEmpty {
                
                if password.count > 9 {
                    
                    
                    
                } else {
                    
                }
                
            }
        }
        
    }
    
}

    


/// TODO: Gender Picker must have the chosing value
/// TODO: Height & Weight must be overlay
/// TODO Height Picker must contain the unit to use and the value
/// TODO Weight Picker must contain the same unit & value
/// TODO: Fix the glitches that occurs while switching between the textfield
class CreateAccountViewController: UIViewController {
    
    var email:     String? = nil
    var password:  String? = nil
    
    /// TODO: Define later either Date or String that must be sent to the server.
    var birthday:  Date?   = nil
    var gender:    String? = nil
    
    var height: (String, String)?
    var weight: (String, String)?
    
    let genderOptions: [String] = ["Male", "Female", "Other"]
    
    let heightUnitOptions: [String] = ["cm"]
    var heightCmValues: [Int] = [Int]()
    var subHeightCmValues: [Int] = [Int]()
    
    let weightUnitOptions: [String] = ["kg"]
    var weightKgValues: [Int] = [Int]()
    var subWeightKgValues: [Int] = [Int]()
    
    /// User input TextField
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    /// Static viewing TextField
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    /// Gender Overlay containing: View, Picker, Exit Button
    @IBOutlet var genderView: UIView!
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet var closeGenderViewButton: UIView!
    
    /// Birthday Overlay containing: View, DatePicker, Exit Button
    @IBOutlet var birthdayView: UIView!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var closeBirthdayViewButton: UIButton!
    
    /// Body Measurements Overlays: Weight & Height
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var heightPicker: UIPickerView!
    @IBOutlet weak var closeHeightViewButton: UIButton!
    
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var closeWeightViewButton: UIButton!
    
    @IBOutlet weak var confirmAccountCreationButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.genderView.frame =   CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.birthdayView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.heightView.frame =   CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.weightView.frame =   CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.genderPickerView.delegate = self
        self.genderPickerView.dataSource = self
    
        self.heightPicker.delegate = self
        self.heightPicker.dataSource = self
                
        self.weightPicker.delegate = self
        self.weightPicker.dataSource = self
        
        for mesure in 30...300 {
            heightCmValues.append(mesure)
            weightKgValues.append(mesure)
        }
        
        for mesure in 0...9 {
            subHeightCmValues.append(mesure)
            subWeightKgValues.append(mesure)
        }
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func openGender(_ sender: UITextField) {
        self.resignFirstResponder()
        self.view.addSubview(self.genderView)
    }
    
    @IBAction func openBirthday(_ sender: UITextField) {
        self.resignFirstResponder()
        self.view.addSubview(self.birthdayView)
    }
    
    @IBAction func openHeight(_ sender: UITextField) {
        self.resignFirstResponder()
        self.view.addSubview(self.heightView)
    }
    
    @IBAction func openWeight(_ sender: UITextField) {
        self.resignFirstResponder()
        self.view.addSubview(self.weightView)
    }
    
    @IBAction func closeBirthday(_ sender: UIButton) {
        
        self.birthday = self.birthdayDatePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        dateFormatter.locale = Locale(identifier: "en_US")
        
        // dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.birthdayTextField.text = String(dateFormatter.string(from: self.birthday!))
        
        self.birthdayView.removeFromSuperview()
    }
    
    @IBAction func closeGender(_ sender: UIButton) {

        self.gender = genderOptions[self.genderPickerView.selectedRow(inComponent: 0)]
        
        self.genderTextfield.text = self.gender!
        
        self.genderView.removeFromSuperview()
    }
    
    @IBAction func closeHeight(_ sender: UIButton) {
        
        let heightRow     = self.heightPicker.selectedRow(inComponent: 0)
        let subHeightRow  = self.heightPicker.selectedRow(inComponent: 1)
        let heightUnitRow = self.heightPicker.selectedRow(inComponent: 2)
        
        self.heightTextField.text = "\(heightCmValues[heightRow]).\(subHeightCmValues[subHeightRow]) \(heightUnitOptions[heightUnitRow])"
        
        self.heightView.removeFromSuperview()
    }
    
    @IBAction func closeWeight(_ sender: UIButton) {
        
        let weightRow     = self.weightPicker.selectedRow(inComponent: 0)
        let subWeightRow  = self.weightPicker.selectedRow(inComponent: 1)
        let weightUnitRow = self.weightPicker.selectedRow(inComponent: 2)
        
        self.weightTextField.text = "\(weightKgValues[weightRow]).\(subWeightKgValues[subWeightRow]) \(weightUnitOptions[weightUnitRow])"
        
        self.weightView.removeFromSuperview()
        
    }
    
    func getWeight() -> Float {
        let selectedWeight = self.weightPicker.selectedRow(inComponent: 0)
        let selectedSubWeight = self.weightPicker.selectedRow(inComponent: 1)
        let weight = Float(self.weightKgValues[selectedWeight])
        let subWeight = Float(subWeightKgValues[selectedSubWeight])/10
        return weight+subWeight
    }
    
    func getHeight() -> Float {
        let selectedHeight = self.heightPicker.selectedRow(inComponent: 0)
        let selectedSubHeight = self.heightPicker.selectedRow(inComponent: 1)
        let height = Float(self.weightKgValues[selectedHeight])
        let subHeight = Float(subWeightKgValues[selectedSubHeight])/10
        return height+subHeight
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        
        /// TODO: Check if all the textfield are not empty.
        /// TODO: All user inputs must be validated before the URL Querie be sent to the server.
        /// TODO: HTTP Method POST to register the user and generate token access
        
        let signUpPath = API.shared.signUpPath
        
        if let firstName = firstnameTextField.text, let lastName = lastnameTextField.text, let gender = genderTextfield.text, let birthday = birthdayTextField.text, let weight = weightTextField.text  {
            if !firstName.isEmpty, !lastName.isEmpty, !gender.isEmpty, !birthday.isEmpty, !weight.isEmpty {
                
                let userData = [
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": email!,
                    "password": password!,
                    "gender": gender,
                    "birthday": birthday,
                    "height": getHeight(),
                    "weight": getWeight()
                    ] as [String : Any]
                
                let session = URLSession.shared
                
                let url = URL(string: signUpPath)!
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let userDataJSON = try! JSONSerialization.data(withJSONObject: userData, options: [])
                
                DispatchQueue.global(qos: .background).async {
                        
                    let task = session.uploadTask(with: request, from: userDataJSON) { data, response, error in
                        
                        if let data = data {
                            
                            do {
                                
                                let serverResponse =  try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String:Any]
                                
                                if serverResponse != nil, serverResponse?.keys.contains("token") ?? false {
                                    
                                    let token = serverResponse?["token"] as? String
                                    
                                    UserDefaults.standard.set(true, forKey: "isLogin")
                                    UserDefaults.standard.set(token, forKey: "token")
                                    
                                    DispatchQueue.main.async {
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        guard let initialViewController = mainStoryboard.instantiateInitialViewController() else { return }

                                        initialViewController.modalPresentationStyle = .fullScreen

                                        self.present(initialViewController, animated: true, completion: nil)
                                    }
                                    
                                } else if serverResponse != nil, serverResponse?.keys.contains("message") ?? false {
                                    
                                }
                                
                            } catch let error as NSError {
                                print(error)
                            }
                            
                        }
                        
                    }
                        
                    task.resume()
                }
                
            }
        }
        
    }
    
}


extension CreateAccountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 0:
            return 1
        default:
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return genderOptions.count
        case 1:
            if component == 0 {
                return heightCmValues.count
            } else if component == 1 {
                return subHeightCmValues.count
            }
            return 1
        case 2:
            if component == 0 {
                return heightCmValues.count
            } else if component == 1 {
                return subHeightCmValues.count
            }
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return genderOptions[row]
        case 1:
            if component == 0 {
                return "\(heightCmValues[row])"
            } else if component == 1 {
                return "\(subHeightCmValues[row])"
            } else {
                return "\(heightUnitOptions[row])"
            }
        case 2:
            if component == 0 {
                return "\(weightKgValues[row])"
            } else if component == 1 {
                return "\(subWeightKgValues[row])"
            } else {
                return "\(weightUnitOptions[row])"
            }
        default:
            return ""
        }
    }
    
}
