import Vapor

struct HeimDall: Middleware {
    let cache: KeyedCache
    let rate: Rate
    
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        
        guard let peer = request.http.remotePeer.hostname else {
            let json = ["status": "500"]
            return try json.encode(for: request)
        }
        
        return cache.get(peer, as: String.self).flatMap { cached in
            // Tired, do it later
        }
    }
}
