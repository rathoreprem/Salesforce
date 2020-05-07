@isTest
public class OppOwnerMailTest 
{
    public static String CRON_EXP = '0 0 0 6 5 ?';
    static testmethod void testOpportunityOwnerMail() 
    {
        List<Opportunity> opptys = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for (Integer i = 0; i < 10; i++) 
        {
            Opportunity o = new Opportunity(Name = 'Opportunity ' + i,
                                            CloseDate = closeDate,
                                            StageName = 'Prospecting');
            opptys.add(o);
        }
        insert opptys;
        Test.startTest();
        System.debug(Limits.getEmailInvocations());
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new OppOwnerMail()); 
        System.debug(Limits.getEmailInvocations());
        System.assertEquals(0, Limits.getEmailInvocations());
        Test.stopTest();   
    }
}