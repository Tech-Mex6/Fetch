//
//  LocalFileManager.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import Foundation

class LocalFileManager {
    static let instance = LocalFileManager()
    private let cacheDirectory: URL
    
    private init() {
        let fileManager = FileManager.default
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    //MARK: - Save Data
    /// - Parameters:
    ///     - data: Generic parameter `T` that conforms to the `Encodable`
    ///     protocol. This is the data to be saved
    ///     - fileName: The name of the file where the data will be saved.
    /// - Description: Encodes the provided data into JSON format and saves it
    ///                to the specified file in the cache directory.
    /// - Return: None
    /// - Error Handling: Catches and prints errors if encoding or writing to the file fails.

    func saveData<T: Encodable>(_ data: T, fileName: String) {
        let url = cacheDirectory.appendingPathComponent(fileName)
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Get Data
    /// - Parameters:
    ///     - fileName: The name of the file from which the data will be retrieved.
    ///     - type: The type of the data to be decoded, which conforms to the `Decodable` protocol.
    /// - Description:Reads the data from the specified file in the cache directory, decodes it from
    /// JSON format and returns it as the specified type
    /// - Return: (Optional of the specified type) Returns the decoded data if successful, otherwise it returns
    /// `nil`.
    /// - Error Handling:
    /// Catches and prints errors if reading from the file or decoding fails and returns `nil`
   
    func getData<T: Decodable>(from fileName: String, as type: T.Type) -> T? {
        let url = cacheDirectory.appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error loading data: \(error.localizedDescription)")
            return nil
        }
    }
    //MARK: - File Exists?
    /// - Parameters:
    ///     - fileName: The name of the file to check for existence.
    /// - Description:
    /// Checks if a file with the specified name exists in the cache directory.
    /// - Return:
    /// Return s `true` if the file exists, otherwise returns `false`
    
    func fileExists(fileName: String) -> Bool {
        let url = cacheDirectory.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: url.path)
    }
    //MARK: - Get File Directory
    /// - Parameters: None
    /// - Description:
    /// Retrieves the URL of the document directory in the user domain.
    /// - Return: Returns the URL of the document directory if successful, otherwise returns `nil`

    private func getFileDirectory() -> URL? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return url
    }
}
