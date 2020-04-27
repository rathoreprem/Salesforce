public class MapStudent {
    public static List<Student__c> getAllStudents(id classId)
    {
        List<Student__c> listOfStudents = [SELECT Name FROM Student__c WHERE class__r.id =: classId];
        return listOfStudents;
    }
    public static map<String, Set<Id>> getMapOfStudents(){
        List<Class__c> classNameWithStudents = [SELECT Name, (SELECT Id FROM Students__r) FROM Class__c];
        Map<String, Set<Id>> mapOfStudents = new Map<String, Set<Id>>();
        for(Class__c classNameWithStudent : classNameWithStudents)
        {
            Set<Id> idSet = new Set<Id>();
            for(Student__c s : classNameWithStudent.Students__r)
            {
                idSet.add(s.id);
            }
            mapOfStudents.put(classNameWithStudent.Name,idSet);            
        }
        return mapOfStudents;
    }
}