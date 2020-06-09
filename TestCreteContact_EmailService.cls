@isTest
private class TestCreteContact_EmailService {
   
   static testMethod void validateContactCreatedByEmail() {
       //test data setup
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
       
       email.subject = 'Test';
       email.fromname = 'Test Test'; 
       env.fromAddress = 'Test@email.com';
       email.plainTextBody = 'Test';
     
		Messaging.InboundEmail.TextAttachment tAttachments = new Messaging.InboundEmail.TextAttachment();
       tAttachments.body ='<?xml version="1.0" encoding="UTF-8"?><Contacts><contact><fname>Ayush</fname><lname>pandey</lname><mailingCity>Jaipur</mailingCity><mailingState>Rajasthan</mailingState><mailingCountry>India</mailingCountry></contact></Contacts>';
       email.textAttachments = new List<Messaging.InboundEmail.TextAttachment>{tAttachments};
        // calling for test  
       CreateContact_EmailService emailProcess = new CreateContact_EmailService();
       Test.startTest();
       emailProcess.handleInboundEmail(email, env);
       Test.stopTest();
       //checking result
       List<Contact> contact =[SELECT FirstName,LastName FROM Contact];
       System.assertEquals(1, contact.size());
   }
}