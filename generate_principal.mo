import Debug "mo:base/Debug";
import Principal "mo:base/Principal";

actor {
    private func createTestPrincipal(seed: Text): Principal {
        Principal.fromText(seed)
    };

    public func generatePrincipal() : async Text {
        let testPrincipal = createTestPrincipal("2vxsx-fae");  // Example valid principal
        Debug.print("Generated Test Principal: " # Principal.toText(testPrincipal));
        Principal.toText(testPrincipal)
    };
}
