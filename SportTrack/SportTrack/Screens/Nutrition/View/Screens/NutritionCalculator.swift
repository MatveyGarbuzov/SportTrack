//
//  NutritionCalculator.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 30.04.2024.
//

import SwiftUI

struct NutritionCalculator: View {

    @EnvironmentObject private var nav: Navigation
    var nutritionGoal: (NutritionData?) -> Void

    @State var sex: Sex = .male
    @State var activity: Activity = .normal
    @State var weight: Int? = nil
    @State var height: Int? = nil
    @State var age: Int? = nil

    var body: some View {
        MainBlock
            .backNavBarButton {
                nutritionGoal(nil)
                goBack()
            }
            .customNavBar(title: "Nutrition calculator")
    }
}

// MARK: - Actions

extension NutritionCalculator {

    func goBack() {
        nav.openPreviousScreen()
    }

    func calculate() -> NutritionData? {
        let totalCalories = Double(totalCalories())
        return NutritionData(
            calories: Int(totalCalories),
            proteins: Int(totalCalories * 0.06),
            fats: Int(totalCalories * 0.03),
            carbs: Int(totalCalories * 0.078)
        )
    }

    func BMR() -> Double {
        sex.totalCoefficient + (sex.weightCoefficient * Double(weight ?? 0)) + (sex.heightCoefficient * Double(height ?? 0)) + (sex.ageCoefficient * Double(age ?? 0))
    }

    func AMR() -> Double {
        activity.coefficient
    }

    func totalCalories() -> Int {
        Int(BMR() * AMR())
    }
}

// MARK: - UI Subviews

extension NutritionCalculator {

    var isTextFieldError: Bool { weight.isNil || weight.isNil || age.isNil }

    var MainBlock: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                SexPicker
                TextFields
                ActivityPicker
                TotalCalories()

                Spacer()
            }
            .padding()
            .padding(.bottom, .SPx15 * 2)
        }
        .overlay(alignment: .bottom) {
            FillButton(title: "\(isTextFieldError ? "Enter all data" : "SAVE")") {
                guard !isTextFieldError else { return }

                nutritionGoal(calculate())
                goBack()
            }
            .padding()
        }
    }

    var SexPicker: some View {
        Picker("", selection: $sex) {
            ForEach(Sex.allCases) { kind in
                Text(LocalizedStringKey(kind.rawValue))
                    .tag(kind)
            }
        }
        .pickerStyle(.segmented)
    }

    var TextFields: some View {
        VStack {
            HStack {
                Text("Weight:")
                    .frame(width: 100)

                TextField("Enter weight", value: $weight, format: .number)
                    .keyboardType(.numberPad)
                    .lineLimit(1...2)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: .CRx3)
                            .fill(.thickMaterial)
                    }
            }

            HStack {
                Text("Height:")
                    .frame(width: 100)

                TextField("Enter height", value: $height, format: .number)
                    .keyboardType(.numberPad)
                    .lineLimit(1...2)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: .CRx3)
                            .fill(.thickMaterial)
                    }
            }

            HStack {
                Text("Age:")
                    .frame(width: 100)

                TextField("Enter age", value: $age, format: .number)
                    .keyboardType(.numberPad)
                    .lineLimit(1...2)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: .CRx3)
                            .fill(.thickMaterial)
                    }
            }
        }
    }

    var ActivityPicker: some View {
        List {
            Picker("", selection: $activity) {
                ForEach(Activity.allCases) { kind in
                    Text(LocalizedStringKey(kind.rawValue))
                        .tag(kind)
                }
            }
            .pickerStyle(.inline)
        }
        .listStyle(PlainListStyle())
        .frame(height: 400)
    }

    func TotalCalories() -> some View {
        let totalString = String(totalCalories())

        return HStack(alignment: .lastTextBaseline) {
            if isTextFieldError {
                Text("Some values not filled :(")
            } else {
                Text(totalString)
                    .title1

                Text("Calories")
                    .headline
                    .foregroundStyle(.secondary)
            }
        }
    }
}


#Preview {
    NutritionCalculator() { _ in }
}
