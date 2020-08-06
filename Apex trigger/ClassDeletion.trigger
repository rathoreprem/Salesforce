trigger ClassDeletion on Class__c (before delete) 
{   
    final static String message = 'Cannot delete Class because in this class more than 1 girls exist';		
    AggregateResult[] Qresult = [SELECT Class__r.Id ClassId, COUNT(Id) NumberOfGirls 
                                 FROM Student__C 
                                 WHERE Sex__c = 'F' 
                                 AND Class__c 
                                 IN:trigger.old 
                                 GROUP BY Class__r.Id];
    for(AggregateResult obj : Qresult )
    {
        System.debug('number of girls ---------------- '+ obj.get('NumberOfGirls'));
         if(integer.valueof(obj.get('NumberOfGirls')) > 1)
         {
            ID clsId = obj.get('classId').toString();
            Trigger.oldMap.get(clsId).addError(message);
    	}
	}
}