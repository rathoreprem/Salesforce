@isTest
private class MapStudentTest 
{
    @testsetup
   	static void testDataForClass() 
    {
        Class__c cls = new Class__c(Name = 'testclass', MaxSize__c = 20);
        insert cls;
        List<Student__c> studentList1 = new  List < Student__c>();
        For(Integer i = 0; i < 5; i++ ) 
        {
            studentList1.add(new Student__c(Name = 'test', LastName__c = 'student'+i, Class__c = cls.Id));
        }
        insert studentList1;
    }
       
    @isTest
    static void getAllStudentByClassId_whenValidClassId_returnAllStudentsOfClass()
    {
        Class__c cls= [SELECT Id 
                       FROM Class__c 
                       LIMIT 1
                      ];
        if(cls.Id != null)
        {
            List<Student__c> studentList2 = MapStudent.getAllStudentByClassId(cls.Id);
            List<Student__c> result = [SELECT Id 
                                       FROM Student__c 
                                       WHERE Class__c = :cls.Id
                                      ];
            System.assertEquals(result.size(), studentList2.size());
        }
    	else
    	{
            List<Student__c> studentList2 = MapStudent.getAllStudentByClassId(cls.Id);
            System.assertEquals(0, studentList2.size());  
    	}
    }
    
    @isTest static void getClassToStudentMap_ClassNameToStudentMap()
    {
        List<Class__c> classList= [SELECT Name,
                                 (SELECT Id 
                                  FROM Students__r
                                  ) 
                               FROM Class__c
                              ];
        Map<String,Set<Id>> classStudentMapexpected = new Map<String, Set<Id>>();    
        for(Class__c cls : classList) 
        {
            Set<Id> studentIds = new Set<Id>();
            for(Student__c student : cls.Students__r) 
            {
                studentIds.add(student.Id);
            }
            classStudentMapexpected.put(cls.Name, studentIds);
        }
        Map<String,Set<Id>> classStudentMap =  MapStudent.getMapOfStudents();
        System.assertEquals(classStudentMapexpected.Size(), classStudentMap.size());
    }  
}