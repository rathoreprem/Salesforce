@isTest
private class AccountUtilTest 
{
    // Test when contactId of account field is null
    @isTest
    static void TestAccountWhenContactIdFieldIsNull()
    {
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Prem', AccountId = acct.Id);
        insert cont;
        AccountUtil.storeContactIds(cont.Id);
        Account act = [SELECT ContactIds__c 
                       FROM Account 
                       WHERE Id =: acct.Id
                      ];
        System.assertnotEquals(string.valueOf(cont.Id), act.ContactIds__c);
    } 
    
    // Test when contactId of account field is not null
    @isTest
    static void TestAccountWhenContactIdFieldIsNotNull()
    {
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont1 = new Contact(LastName = 'Prem', AccountId = acct.Id);
        insert cont1;
        acct.ContactIDs__c = cont1.Id;
        update acct;
        Contact cont2 = new Contact(LastName = 'Prem', AccountId = acct.Id);
        insert cont2;
        AccountUtil.storeContactIds(cont2.Id);
        Account act = [SELECT ContactIds__c 
                       FROM Account 
                       WHERE Id =: acct.Id
                      ];
        String allContactIds = cont1.Id +','+ cont2.Id ;
        System.assertEquals(allContactIds, act.ContactIds__c);
    } 
}