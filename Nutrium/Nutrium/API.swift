import Alamofire

class API {
    private let API_BASE_PATH = "https://nutrisearch.vercel.app"
    private let API_PROFESSIONALS_PATH = "/professionals/search"
    private let API_PROFESSIONAL_DETAIL_PATH = "/professionals/"

    static let shared = API()
    
    var session: Session
    
    init() {
        let memoryCapacity = 10 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: nil)
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.urlCache = urlCache
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.timeoutIntervalForRequest = 30
        
        self.session = Session(configuration: sessionConfiguration)
    }
    
    func getProfessionals(sortOption : String, offset: Int? = nil) async -> [Professional]? {
        let url = API_BASE_PATH + API_PROFESSIONALS_PATH
        
        let parameters: [String: Any] = [
                    "sort_by": sortOption,
                    "offset": offset,
        ]

        do {
            let response = try await session.request(url, parameters: parameters)
                .serializingDecodable(ProfessionalResponse.self)
                .value

            //await PersistenceController.shared.saveProfessional(response.professionals)
                        
            print(response.professionals)
            return response.professionals
        } catch {
            print("Failed to get professionals: \(error.localizedDescription)")
            return nil
        }
    }

    func getProfessionalProfile(id: String) async -> Professional? {
        let urlString = API_BASE_PATH + API_PROFESSIONAL_DETAIL_PATH + id
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        if let cachedResponse = AF.session.configuration.urlCache?.cachedResponse(for: request) {
            do {
                let cachedProfessional = try JSONDecoder().decode(Professional.self, from: cachedResponse.data)
                return cachedProfessional
            } catch {
                print("Failed getProfessionalProfileCache: \(error.localizedDescription)")
            }
        }
        
        do {
            let response = try await session.request(urlString)
                .serializingDecodable(Professional.self)
                .value
            return response
        } catch {
            print("Failed getProfessionalProfile: \(error.localizedDescription)")
            return nil
        }
    }
}
