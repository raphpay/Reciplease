//
//  SearchVC+Ext.swift
//  Reciplease
//
//  Created by Raphaël Payet on 27/05/2021.
//

import UIKit

extension SearchVC: UITextFieldDelegate {
    
    func configureTextField() {
        ingredientsTextField.delegate = self
    }
    
    
    func addIngredientToTextView(text: String) {
        ingredientsTextView.text = "\n\(text)"
        ingredientsTextField.text = ""
        ingredientsInFridge.append(text)
        print(ingredientsInFridge)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        addIngredientToTextView(text: text)
        return true
    }
}
