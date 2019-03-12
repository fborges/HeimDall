import Vapor

public struct HeimDall: Middleware {
    let cache: KeyedCache
    let rate: Rate
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        
        guard let peer = request.http.remotePeer.hostname else {
            let json = ["status": "500"]
            return try json.encode(for: request)
        }
        
        return cache.get(peer, as: [String:Double].self).flatMap { cached in
            guard
                let creationTimeStamp = cached?[Keys.created],
                var requests = cached?[Keys.requests] else {
                return try self.reset(peer, next: next, request: request)
            }
            
            if Date().isAheadOf(
                   date: Calendar.current.date(
                       byAdding: self.rate.dateComponents(),
                       to: Date(timeIntervalSince1970: creationTimeStamp))!) {
                return try self.reset(peer, next: next, request: request)
            }
            
            if requests > Double(self.rate.rate) {
                let json = ["status": "429",
                        "message": "Rate limit exceeded."]
                return try json.encode(for: request)
            }
            
            defer {
                requests += 1
                _ = self.cache.set(peer, to: [Keys.created: creationTimeStamp, Keys.requests: requests])

            }
    
            return try next.respond(to: request)
        }
    }
    
    func reset(_ peer: String, next: Responder, request: Request) throws -> EventLoopFuture<Response>  {
        _ = cache.set(peer, to: [Keys.created: Date().timeIntervalSince1970, Keys.requests: 0])
        return try next.respond(to: request)
    }
}
