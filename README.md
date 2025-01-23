# Secure Token Wallet

## Prerequisites
- Internet Computer SDK (dfx) installed
- Local development environment setup

## Deployment Steps

### 1. Start Local Network
```bash
dfx start
```

### 2. Create Canisters
```bash
dfx canister create --all
```

### 3. Build Canisters
```bash
dfx build
```

### 4. Deploy Mock Ledger
```bash
dfx deploy mock_ledger --with-cycles 50000000000000
```

### 5. Deploy Principal Generator
```bash
dfx deploy generate_principal --with-cycles 50000000000000
```

### 6. Generate Test Principal
```bash
dfx canister call generate_principal generatePrincipal
```
**Note:** Save the generated principal ID for subsequent steps.

### 7. Deploy Token Manager
```bash
dfx deploy token_manager --with-cycles 50000000000000 --argument '(service "<mock_ledger_canister_id>")'
```
Replace `<mock_ledger_canister_id>` with the actual Mock Ledger canister ID.

### 8. Deploy Wallet Security
```bash
dfx deploy wallet_security --with-cycles 50000000000000 --argument '(principal "<test_principal>")'
```
Replace `<test_principal>` with the principal generated in step 6.

### 9. Deploy Unit Tests
```bash
dfx deploy unit_tests --with-cycles 50000000000000
```

### 10. (Optional) Send Additional Cycles to Unit Tests Canister
```bash
dfx wallet send 50000000000000 <unit_tests_canister_id>
```
Replace `<unit_tests_canister_id>` with the actual Unit Tests canister ID.

### 11. Run Unit Tests
```bash
dfx canister call unit_tests test
```

## Troubleshooting
- Ensure all canister IDs are correctly replaced in deployment commands
- Verify sufficient cycle allocation for each canister
- Check Internet Computer SDK and local network configuration

## Requirements
- Internet Computer SDK
- Cycles for canister deployment
- Test environment setup

## Notes
- Deployment steps may vary based on specific project configuration
- Always refer to the most recent project documentation

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
