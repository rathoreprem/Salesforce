trigger MaxLimitTrigger on Student__c (before insert) 
{
    final static string MESSAGE = 'Class size is Full. Please select another class';
	if(Trigger.isInsert) 
    {
       Set<ID> classIds = new Set<ID>();
       for(Student__c std : Trigger.New) 
       {
           classIds.add(std.Class__c);
       }
       List<Class__c> classList = [SELECT NumberOfStudents__c, MaxSize__c 
                                   FROM Class__c
                                   WHERE Id 
                                   IN :classIds];
       Map<Id, Class__c> classMapById = new Map<Id, Class__c> (classList);
       for(Student__c student : Trigger.new) 
       {
           Class__c classOfStudent = classMapById.get(student.Class__c);
           if(classOfStudent.MaxSize__c == classOfStudent.NumberOfStudents__c) 
           {
               student.addError(message);
           }
       }
	}
}