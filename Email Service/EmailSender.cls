public class EmailSender {
    public static void sendOpportunityUpdateMail(List<Opportunity> emailopportunityList)
    {
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        EmailTemplate emailTemplateRecord = [SELECT Id FROM EmailTemplate WHERE DeveloperName LIKE 'OpportunityUpdateEmail' LIMIT 1];
        List<Opportunity> opportunityList = [SELECT Id,Name,Owner.Email FROM Opportunity Where Id in:emailopportunityList];
        for(Opportunity opportunityRecord: opportunityList)
        {
            Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(emailTemplateRecord.Id, opportunityRecord.OwnerId, opportunityRecord.Id);
            mail.setToAddresses(new List<String>{opportunityRecord.Owner.Email});
            System.debug(opportunityRecord.Owner.Email);
            mail.setSaveAsActivity(false);
            allmsg.add(mail);
        }
        System.debug(opportunityList);
        try {
            Messaging.sendEmail(allmsg,true);
            return;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }  
}