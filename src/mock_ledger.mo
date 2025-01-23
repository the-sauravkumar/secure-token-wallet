import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Trie "mo:base/Trie";
import Result "mo:base/Result";

actor class MockLedger() {
    private stable var balances: Trie.Trie<Text, Nat> = Trie.empty();

    private func key(t: Text): Trie.Key<Text> {
        { key = t; hash = Text.hash(t) }
    };

    public func getBalance(owner: Text): async ?Nat {
        Trie.get(balances, key(owner), Text.equal)
    };

    public func credit(owner: Text, amount: Nat): async Text {
        let newBalance = switch (Trie.get(balances, key(owner), Text.equal)) {
            case (?currentBalance) currentBalance + amount;
            case null amount;
        };
        balances := Trie.put(balances, key(owner), Text.equal, newBalance).0;
        "Balance updated."
    };

    public func debit(owner: Text, amount: Nat): async Result.Result<Text, Text> {
        switch (Trie.get(balances, key(owner), Text.equal)) {
            case (?currentBalance) {
                if (currentBalance < amount) {
                    #err("Insufficient funds.")
                } else {
                    let newBalance = currentBalance - amount;
                    balances := Trie.put(balances, key(owner), Text.equal, newBalance).0;
                    #ok("Transaction successful.")
                }
            };
            case null {
                #err("Account not found.")
            }
        }
    };

    public func sendTokens(from: Text, to: Text, amount: Nat): async Result.Result<Text, Text> {
        switch (await debit(from, amount)) {
            case (#ok _) {
                ignore await credit(to, amount);
                #ok("Tokens transferred successfully.")
            };
            case (#err e) {
                #err(e)
            }
        }
    };
}
