//
//  ContentView.swift
//  TipCalculatorApp
//
//  Created by Caleb Bellmyer on 1/31/25.
//

import SwiftUI


struct Title: View {
    var body: some View {
        Text("Tip Calculator")
            .font(.largeTitle)
            .bold()
            
    }
}


struct ContentView: View {
    @State var billAmount: Double = 100
    @State var tipPercentage: Double = 0.15
    @State var numberOfPeople: Double = 1.0
    @State var showResult: Bool = false
    
    var tipAmount: Double {
     return   billAmount * tipPercentage
    }
    
    var totalAmount: Double {
        return billAmount + tipAmount
    }
    
    var amountPerPerson: Double {
        return numberOfPeople > 0 ? totalAmount / numberOfPeople: 0
    }
   // abstracted all my slider info 
    struct SliderView: View {
        let title: String
        @Binding var value: Double
        let range: ClosedRange<Double>
        let step: Double
        let format: (Double) -> String
        let color: Color
        
        var body: some View {
            VStack {
                Text("\(title):")
                    .multilineTextAlignment(.center)
                    .bold()
                    .font(.title2)
                Text("\(format(value))")
                    .foregroundColor(color)
                    .font(.title3)
                    .bold()
                Slider(value: $value, in: range, step: step)
                    .tint(color)
            }
            .padding();
        }
    }
    
    var body: some View {
        VStack {
            Title()
            
            SliderView(title: "Bill Amount", value: $billAmount, range: 0...500, step: 0.01, format: { value in value.formatted(.currency(code: "USD"))}, color: .purple)
            
            SliderView(title: "Tip Percentage", value: $tipPercentage, range: 0...0.3, step: 0.01, format: { value in value.formatted(.percent)}, color: .green)
            
            SliderView(title: "Number of People", value: $numberOfPeople, range: 1...20, step: 1.0, format: { value in "\(Int(value))"}, color: .orange)
            
            
            VStack {
                Button(action: {
                    showResult.toggle()
                }) {
                    Text(showResult ? "Hide Result" : "Calculate")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(showResult ? Color.red : Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .padding()
            }
            .padding()
            
                VStack(spacing: 1) {
                    Text("Tip Amount: \(tipAmount, format: .currency(code: "USD"))")
                    Text("Total: \(totalAmount, format: .currency(code: "USD"))")
                    Text("Amount Per Person: \(amountPerPerson, format: .currency(code: "USD"))")
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                )
                .shadow(radius: 3)
                .padding()
                .opacity(showResult ? 1 : 0)
            }
        .animation(.easeInOut, value: showResult)
    }
}

#Preview {
    ContentView()
}
