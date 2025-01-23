import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import WalletSecurity "../src/wallet_security";
import TokenManagerClass "../src/token_manager";
import MockLedgerClass "../src/mock_ledger";

actor UnitTests {
    private func createTestPrincipal(seed: Text): Principal {
        // Use valid principal format
        Principal.fromText("2vxsx-fae")
    };

    // Use MockLedger instead of the actual ledger
    public func testTokenManagerBalanceOperations() : async () {
        Debug.print("Starting TokenManager Balance Operations Tests");

        let mockLedger = await MockLedgerClass.MockLedger();
        let tokenManager = await TokenManagerClass.TokenManager(mockLedger);

        let creditResult1 = await tokenManager.credit("alice", 100);
        assert(creditResult1 == "Balance updated.");

        let balance1 = await tokenManager.getBalance("alice");
        switch (balance1) {
            case (?b) { assert(b == 100); };
            case null { assert(false); };
        };

        // Additional tests...

        Debug.print("TokenManager Balance Operations Tests Completed");
    };

    public func testWalletSecurityOwnershipFunctions() : async () {
        Debug.print("Starting WalletSecurity Ownership Tests");

        let owner = createTestPrincipal("owner");
        let nonOwner = createTestPrincipal("non-owner");
        let newOwner = createTestPrincipal("new-owner");

        let walletSecurityCanister = await WalletSecurity.WalletSecurity(owner);

        let isInitialOwner = await walletSecurityCanister.isOwner(owner);
        assert(isInitialOwner == true);

        // Additional tests...

        Debug.print("WalletSecurity Ownership Tests Completed");
    };

    public func runAllTests() : async () {
        await testTokenManagerBalanceOperations();
        await testWalletSecurityOwnershipFunctions();
        Debug.print("All Tests Completed Successfully");
    };

    public func test() : async () {
        await runAllTests();
    };
}
