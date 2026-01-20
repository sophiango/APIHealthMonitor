//
//  ContentView.swift
//  APIHealthMonitor
//
//  Created by Sophia Ngo on 1/20/26.
//

import SwiftUI

struct ContentView: View {
	
	@State private var apiURL: String = ""
	@State private var statusMsg: String = "Enter an API endpoint and tap Check"
	
    var body: some View {
		VStack(spacing: 16) {
            Text("API Health Monitor")
				.font(.title)
				.fontWeight(.bold)
			TextField("https://api.example.com/health", text: $apiURL)
				.textFieldStyle(RoundedBorderTextFieldStyle())
#if os(iOS)
                .keyboardType(.URL)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
#endif
			Button("Check Health") {
				checkHealth()
			}.buttonStyle(.borderedProminent)
			Text(statusMsg).foregroundColor(.gray)
			Spacer()
        }
        .padding()
    }
	
    // MARK: - Actions
    private func checkHealth() {
        if apiURL.isEmpty {
            statusMsg = "❌ Please enter a valid URL"
        } else {
            statusMsg = "✅ URL looks good (networking coming next)"
        }
    }
}

#Preview {
    ContentView()
}
