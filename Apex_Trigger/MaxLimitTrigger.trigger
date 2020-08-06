trigger MaxLimitTrigger on Student__c (before insert) 
{
	if(Trigger.isInsert) 
    {
       List<ID> classIds = new List<ID>();
       for(Student__c std : Trigger.New) 
       {
           classIds.add(std.Class__c);
       }
       List<Class__c> ClassList = [Select NumberOfStudents__c,MaxSize__c,(Select Id from Students__r) from Class__c where Id IN :classIds];
       for(Class__c cls : ClassList) 
       {
           if(cls.MaxSize__c == cls.NumberOfStudents__c) 
           {
               Trigger.New[0].addError('Class size is Full. Please select another class');
           }
       }
	}
}