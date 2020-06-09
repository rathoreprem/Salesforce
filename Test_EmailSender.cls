@isTest
private class Test_EmailSender {
   @isTest
   private static void testEmailInvocation() {
       Opportunity testOpp =new Opportunity(Name='testOppt',CloseDate=Date.newInstance(2021, 2, 17),StageName='Prospecting');
       insert testOpp;
       Test.startTest();
       testOpp.StageName='Close Won';
       update testOpp;
       Integer afterinvocations = Limits.getEmailInvocations();
       Test.stopTest();
       System.assertEquals(1,afterinvocations);
   }
}