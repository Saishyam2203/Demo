public class BadExampleClass {
    public void processAccounts() {
        // Query inside a loop (potential for SOQL governor limit exception)
        List<Account> accounts = [SELECT Id, Name FROM Account];
        for (Account acc : accounts) {
            // Inefficient SOQL within loop
            List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE AccountId = :acc.Id];
            for (Contact con : contacts) {
                // Poor exception handling (no catch block)
                try {
                    con.Description = 'Updated by processAccounts';
                    update con;
                } catch (Exception e) {
                    // No error logging or meaningful response
                }
            }
        }
    }
    public void updateSingleAccount() {
        // Hardcoding Ids (bad practice)
        Account acc = [SELECT Id, Name FROM Account WHERE Id = '001xx000003DGb2'];
        acc.Name = 'New Name';
        update acc;
    }
}