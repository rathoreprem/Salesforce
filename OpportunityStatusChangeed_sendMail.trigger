trigger OpportunityStatusChangeed_sendMail on Opportunity (after update) {
    if(trigger.isAfter)
    {
        List<Opportunity> emailListOpportunity = new List<Opportunity>();
		for(Opportunity opportunityRecord : (List<Opportunity>)trigger.new )
        {
            if(trigger.oldMap.get(opportunityRecord.Id).StageName != opportunityRecord.StageName)
            {
                emailListOpportunity.add(opportunityRecord);
            }
        }
        EmailSender.sendOpportunityUpdateMail(emailListOpportunity);
    }
    
}