import Kitura
import HeliumLogger
import LoggerAPI

HeliumLogger.use()

let router = Router()
var mySSLConfigSelfSigned: SSLConfig
var mySSLConfigChain: SSLConfig

mySSLConfigSelfSigned = try TestSelfSigned()
mySSLConfigChain = try TestCertChain()

// TODO: Gelareh to addres this
// #if os(Linux)
//     mySSLConfigSelfSigned.cipherSuite = "ALL"
//     mySSLConfigChain.cipherSuite = "ALL"
// #endif // os(Linux)

router.get("/") {
    request, response, next in
    response.send("Hello, World!")
    next()
}

// if a procfile exists, pick up port from there. Else, assign 8090 by default
let (ip, port) = parseAddress()

// https://localhost:8090
Kitura.addHTTPServer(onPort: port, with: router, withSSL: mySSLConfigSelfSigned)

//// https://localhost:8080
//Kitura.addHTTPServer(onPort: 8080, with: router, withSSL: mySSLConfigChain)

Kitura.run()
