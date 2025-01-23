//wallet_security.mo
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Error "mo:base/Error";

actor class WalletSecurity(initialOwner: Principal) {
    // Store owner as stable to persist across upgrades
    private stable var owner: Principal = initialOwner;

    // Check if a principal is the owner
    public shared query func isOwner(caller: Principal) : async Bool {
        caller == owner;
    };

    // Verify caller's ownership
    public shared(msg) func verifyOwnership() : async Result.Result<(), Text> {
        if (msg.caller == owner) {
            #ok(());
        } else {
            #err("Unauthorized access: " # Principal.toText(msg.caller));
        };
    };

    // Allow owner to transfer ownership
    public shared(msg) func transferOwnership(newOwner: Principal) : async Result.Result<(), Text> {
        if (msg.caller != owner) {
            return #err("Only the current owner can transfer ownership");
        };
        
        if (Principal.isAnonymous(newOwner)) {
            return #err("Cannot transfer ownership to anonymous principal");
        };

        owner := newOwner;
        #ok(());
    };

    // Get current owner
    public query func getOwner() : async Principal {
        owner;
    };

    // Check if principal is anonymous
    public query func isAnonymous(p: Principal) : async Bool {
        Principal.isAnonymous(p);
    };

    // Trap if caller is not owner
    public shared(msg) func assertIsOwner() : async () {
        if (msg.caller != owner) {
            throw Error.reject("Unauthorized: Not the owner");
        };
    };
}