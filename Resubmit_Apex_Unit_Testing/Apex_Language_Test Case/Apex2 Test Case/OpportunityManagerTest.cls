@isTest
public class OpportunityManagerTest 
{
    // Test when BillToContact__c field is not null and manager fiels is null 
    @isTest
    static void testOpportunityManage_BillTocontact_is_notNull_But_Manager_null()
    {
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Prem', AccountId = acct.Id);
        insert cont;
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < 10; i++)
        {
            Opportunity opp = new Opportunity(Name = 'Name' + i, 
                                              CloseDate = System.Date.today(), 
                                              StageName = 'Closed Won', 
                                              BillToContact__c = cont.Id
                                             );
            opps.add(opp);
        }
        insert opps;
        OpportunityManager.updateManagerToAccountInOpp(opps);
        List<Opportunity> oppList = [SELECT Manager__c FROM Opportunity];
        for(Integer i = 0; i < 10; i++)
        {
            System.assertEquals(acct.Id, oppList[i].Manager__c);
        }
    }
    
    // Test when BillToContact__c field is null and manager fiels is also null 
    @isTest
    static void testOpportunityManage_BillTocontact_Null_Also_Manager_null()
    {
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Prem', AccountId = acct.Id);
        insert cont;
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < 10; i++)
        {
            Opportunity opp = new Opportunity(Name = 'Name' + i, CloseDate = System.Date.today(), StageName = 'Closed Won');
            opps.add(opp);
        }
        insert opps;
        OpportunityManager.updateManagerToAccountInOpp(opps);
        List<Opportunity> oppList = [SELECT Manager__c 
                                     FROM Opportunity];
        for(Integer i = 0; i < 10; i++)
        {
            System.assertEquals(null, oppList[i].Manager__c);
        }
    }
}