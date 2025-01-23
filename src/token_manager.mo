import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Trie "mo:base/Trie";
import Result "mo:base/Result";
import MockLedgerClass "../src/mock_ledger";

actor class TokenManager(ledger: MockLedgerClass.MockLedger) {
    private var ledgerRef: MockLedgerClass.MockLedger = ledger;

    public func getBalance(owner: Text): async ?Nat {
        await ledgerRef.getBalance(owner)
    };

    public func credit(owner: Text, amount: Nat): async Text {
        await ledgerRef.credit(owner, amount)
    };

    public func debit(owner: Text, amount: Nat): async Result.Result<Text, Text> {
        await ledgerRef.debit(owner, amount)
    };

    public func sendTokens(from: Text, to: Text, amount: Nat): async Result.Result<Text, Text> {
        await ledgerRef.sendTokens(from, to, amount)
    };
}
