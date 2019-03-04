//
//  MemeCreatorController.swift
//  MemePractice
//
//  Created by Administrator on 9/6/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class MemeCreatorController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Properties
    
    // memeTextAttributes sets the color, font and stroke of the field text.
    // (strokeWidth.rawValue must be negative to allow foregroundColor to appear as designed).
    
    let memeTextAttributes: [String: Any] = [
        NSAttributedString.Key.strokeColor.rawValue: UIColor.black,
        NSAttributedString.Key.foregroundColor.rawValue: UIColor.white,
        NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth.rawValue: -4.0]

    // MARK: Visible Assets
    
    @IBOutlet weak var memePic: UIImageView!
    @IBOutlet weak var memeToolbar: UIToolbar!
    @IBOutlet weak var chooseAnImage: UIBarButtonItem!
    @IBOutlet weak var snapAnImage: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // Determining the initial state of assets after the app loads.

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        textAttributes(textField: topTextField, textParameter: "TOP")
        textAttributes(textField: bottomTextField, textParameter: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        snapAnImage.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = (memePic.image != nil)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Toolbar Functions
    // memeSelector sets the functionality shared by imageSelect and cameraSelect.
    
    func memeSelector(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    // This action is linked to the Choose an Image button.  This brings up the OS Photo Library.
    
    @IBAction func imageSelect(_ sender: Any) {
        memeSelector(source: .photoLibrary)
    }
    
    // This action is linked to the Snap an Image (camera) button.  The snapAnImage.isEnabled line in viewWillAppear currently disables the button in Simulator.
    
    
    @IBAction func cameraSelect(_ sender: Any) {
        memeSelector(source: .camera)
    }
    
    // This is linked to the Share (box with arrow) button.  The shareButton.isEnabled line will keep the button disabled, until an image is added to memePic.
    
    @IBAction func share(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = {
            (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // Added Cancel functionality since this viewController is being presented, instead of pushed.
    
    @IBAction func cancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: textField Properties
    
    // textField method is used for allowing users to update the text fields.
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        
        return true
    }
    
    // textAttributes sets up the font, text color and alignment.  Must be added to viewDidLoad.
    
    func textAttributes(textField: UITextField, textParameter: String) {
        textField.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(memeTextAttributes)
        textField.textAlignment = .center
        textField.text = textParameter
    }
    
    // Clears the default text when the users begin editing.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(topTextField.text == "TOP") {
            topTextField.text = ""
        }
        if(bottomTextField.text == "BOTTOM") {
            bottomTextField.text = ""
        }
    }
    
    // Checks the field to ensure it isn't empty.
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(topTextField.text!.isEmpty) {
            topTextField.text = "TOP"
        }
        if(bottomTextField.text!.isEmpty) {
            bottomTextField.text = "BOTTOM"
        }
    }
    
    // textFieldShouldReturn will dismiss the keyboard automatically when Return is tapped.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(topTextField.text == "") {
            topTextField.text = "TOP"
        }
        if(bottomTextField.text == "") {
            bottomTextField.text = "BOTTOM"
        }
        
        return true;
    }
    
    // MARK: Photo Library Behavior
    
    // This method links user's selected image to the UIView and dismisses the OS Photo Library after selection.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        picker.dismiss(animated: true, completion: nil)
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            memePic.image = image
        }
    }
    
    // Allows the OS Photo Library to be dismissed without updating the UIImageView.
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Text Field Obscurrance Prevention
    
    // This moves the keyboard upward after users tap the bottom field.
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            //let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                //(self.navigationController?.navigationBar.frame.height ?? 0.0)
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // This moves the keyboard to its original position after users finish editing a field.
    
    @objc func keyboardWillDisappear(_ notification: Notification) {
        //let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            //(self.navigationController?.navigationBar.frame.height ?? 0.0)
        view.frame.origin.y = 0
    }
    
    // Retrieves the exact height of the keyboard for keyboardWillShow.
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // These are necessary for the app to listen for and ignore information about the keyboard.
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: Save Feature
    
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memePic.image!, memedImage: generateMemedImage())
        
        // MemeMe 2.0 Update
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        memeToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        memeToolbar.isHidden = false
        
        return memedImage
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
