trigger ClassDeletion on Class__c (before delete) 
{
		AggregateResult[] r = [SELECT Class__r.id classId, COUNT(id) NumberOfGirls FROM Student__C WHERE Sex__c = 'Female' AND Class__c IN:trigger.old GROUP BY Class__r.id];
    for(AggregateResult re : r )
    {
         if(integer.valueof(re.get('NumberOfGirls')) > 1)
         {
            ID clsId = re.get('classId').toString();
            Trigger.oldMap.get(clsId).addError('Cannot delete Class because in this class more than 1 girls exist.');
    	}
	}
}