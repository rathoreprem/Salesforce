trigger StudentCountTrigger on Student__c (after insert,after update) 
{
	List<class__c> listOfClassesToUpdate=new List<class__c>();
    listOfClassesToUpdate=[select id,mycount__c,(select id from students__r) from class__c where id in (select class__c from student__c where id in:Trigger.New)];
    for(class__c classToUpdate:listOfClassesToUpdate)  
    {
        classToUpdate.mycount__c=classToUpdate.students__r.size();
    }
    update listOfClassesToUpdate;
}