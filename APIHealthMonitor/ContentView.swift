//
//  ContentView.swift
//  APIHealthMonitor
//
//  Created by Sophia Ngo on 1/20/26.
//

import SwiftUI

struct ContentView: View {
	
	@State private var isLoading: Bool = false
	@State private var apiURL: String = ""
	@State private var statusMsg: String = ""
	
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
			
			Button {
				Task {
					await checkHealth()
				}
			} label: {
				if isLoading {
					ProgressView()
				} else {
					Text("Check Health")
				}
			}
			.buttonStyle(.borderedProminent)
			Text(statusMsg).foregroundColor(.gray)
			Spacer()
        }
        .padding()
    }
	
    // MARK: - Actions
    private func checkHealth() async {
		guard let url = URL(string: apiURL) else {
			statusMsg = "❌ Please enter a valid URL"
			return
		}
        
		isLoading = true
		statusMsg = "Checking..."
		
		let startTime = Date()
		do {
			let (_, response) = try await URLSession.shared.data(from: url)
			let duration = Date().timeIntervalSince(startTime)
			if let httpResponse = response as? HTTPURLResponse {
				statusMsg = """
					Status: \(httpResponse.statusCode)
					Response time: \(Int(duration)) ms
					"""
			} else {
				statusMsg = "❌ Failed to get a valid HTTP response"
			}
		} catch {
			statusMsg = "❌ Request failed \(error.localizedDescription)"
		}
		isLoading = false
    }
}

#Preview {
    ContentView()
}
