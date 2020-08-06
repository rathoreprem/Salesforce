@isTest
public class StageOfOpportunityTest 
{
	/**
     * Change the stage from Prospecting to closed won then close date will be changed with date of today
     */
    @isTest
    static void stageOfOpportunityTestByUpdateStatusToCLoseWon()
    {
        List<Opportunity> Opportunities = new List<Opportunity>();
       	for(Integer i = 0; i < 20; i++)
        {
            Date dt = System.today().addMonths(1);
   			Opportunity opp = new Opportunity(Name = 'Opportunity Test', StageName = 'Prospecting', CloseDate = dt);
            Opportunities.add(opp);
       	}
       	insert Opportunities;
        Test.startTest();
        for(Integer i = 0 ; i < 20 ; i++)
        {
            Opportunities[i].StageName = 'CLOSED WON';
        }
        Database.SaveResult[] results = Database.update(Opportunities, false);
        Test.stopTest();
        for(Database.SaveResult result : results) 
        {
            System.assert(result.isSuccess());
        }
        List<Opportunity> oppList = [SELECT CloseDate 
                                     FROM Opportunity];
        for(Opportunity opp : oppList) 
        {
            System.assertEquals(System.today(), opp.CloseDate);
        }
    }
    
    
    /**
     * Change the stage from closed won to other then close date will remain same
     */
    @isTest
    static void stageOfOpportunityTestByUpdateStatusToOther()
    {
        List<Opportunity> Opportunities = new List<Opportunity>();
       	for(Integer i = 0; i < 20; i++)
        {
            Date dt = System.today().addMonths(1);
   			Opportunity opp = new Opportunity(Name = 'Opportunity Test', StageName = 'Prospecting', CloseDate = dt);
            Opportunities.add(opp);
       	}
       	insert Opportunities;
        Test.startTest();
        for(Integer i = 0; i < 20; i++)
        {
            Opportunities[i].StageName = 'Prospecting';
        }
        Database.SaveResult[] results = Database.update(Opportunities, false);
        Test.stopTest();
        for(Database.SaveResult result : results) 
        {
            System.assert(result.isSuccess());
        }
        List<Opportunity> oppList = [SELECT CloseDate 
                                     FROM Opportunity];
        for(Opportunity opp : oppList) 
        {
            Date dt = System.today().addMonths(1);
            System.assertEquals(dt, opp.CloseDate);
        }
    }
}