//
//  ViewController.swift
//  SecondsInMyLife

//  Created by Антон Баландин on 26.09.23.


import UIKit

class ViewController: UIViewController {

    private var label: UILabel = {
        let label = UILabel()
        label.text = "Select your date of birth"
        label.textAlignment = .center
        label.backgroundColor = .green
        label.numberOfLines = .max
        return label
    }()
    
    private var labelResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.numberOfLines = .max
        return label
    }()
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
    
        picker.center = view.center
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.maximumDate = .now
        picker.addTarget(self, action: #selector(datePickerChange(paramDatePicker:)), for: .valueChanged)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(labelResult)
        view.addSubview(picker)
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        labelResult.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            label.heightAnchor.constraint(equalToConstant: view.frame.size.width/7),
            
            labelResult.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            labelResult.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelResult.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            labelResult.heightAnchor.constraint(equalToConstant: view.frame.size.width/4)
        ])
    }

    @objc func datePickerChange(paramDatePicker: UIDatePicker) {
        if paramDatePicker.isEqual(self.picker) {
            let formatter = DateFormatter()
            
            formatter.dateFormat = "yyyy"
            let yearOfBirthString = formatter.string(from: picker.date)
            let yearOfBirth = Int(yearOfBirthString)
            
            formatter.dateFormat = "M"
            let monthOfBirthString = formatter.string(from: picker.date)
            let monthOfBirth = Int(monthOfBirthString)
            
            formatter.dateFormat = "d"
            let dayOfBirthString = formatter.string(from: picker.date)
            let dayOfBirth = Int(dayOfBirthString)
            
            let date = Date()
            let calendar = Calendar.current
            
            let currentDay = calendar.component(.day, from: date)
            let currentMonth = calendar.component(.month, from: date)
            let currentYear = calendar.component(.year, from: date)

            let secondsPerDay = 60 * 60 * 24
            let daysPerMonth = 30
            let daysPerYear = 360

            var daysFromBirth = (currentYear - yearOfBirth!) * daysPerYear
            daysFromBirth += (currentMonth - monthOfBirth!) * daysPerMonth
            daysFromBirth += currentDay - dayOfBirth!

            let secondsFromBirth = secondsPerDay * daysFromBirth
            let yearsFromBirth = secondsFromBirth / secondsPerDay / daysPerYear
            let monthFromBirth = secondsFromBirth / secondsPerDay / daysPerMonth

            labelResult.text = "\(yearsFromBirth) years, \(monthFromBirth) months, \(daysFromBirth) days and \(secondsFromBirth) seconds have passed since my birth"
        }
    }
}



