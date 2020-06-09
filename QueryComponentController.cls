public class QueryComponentController {
    public String inputQuery {get; set;}
    public List<String> fieldList {get; set;}
    private Integer pageSize = 10;
    private final String SORT_DESC = 'DESC';
    private final String SORT_ASC = 'ASC';
    private String sortDirection;
    public String sortBy{get;set;}
    public  QueryComponentController(){
        fieldList = new List<String> ();
        sortDirection = SORT_DESC; 
    }
    public ApexPages.StandardSetController setController {
        get {
            if(setController==null){
                List<SObject> records = getQueryResult();
                if(records != null){
                    setController = new ApexPages.StandardSetController(records);
                    setController.setPageSize(pageSize);
                    if(records.size() > 0)
                    {
                        initializeFieldList(records[0]);
                    }
                }
            }
            return setController;
        }
        set;
    }
    
    
    public List<SObject> getQueryResult()
    {
        List<SObject> result = new List<SObject>();
        try{
            String query = createQuery(inputQuery); 
            system.debug(query);
            result = DataBase.query(query);   
        }
        catch(MyException ex)
        {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
            ApexPages.addMessage(msg);       
        }
        return result;
    }
    public class MyException extends Exception {} 
    
    public List<sObject> getQueryRecords()
    {
        system.debug(setController.getRecords());
        return setController.getRecords();
    }
    public void sort()
    {
        setController = null;       
    }
    public Integer getPageSize(){
        return pageSize;
    }
    
    
    public void setPageSize(Integer pageSize){
        this.pageSize= pageSize; 
    }
    private void initializeFieldList(SObject record)
    {
        Set<String> fieldSet = record.getPopulatedFieldsAsMap().keySet();
        fieldList.clear();
        fieldList.addAll(fieldSet); 
    }
    
    
    private String createQuery(String query) 
    {
        String createdQuery = query;
        if(sortBy != null) 
        {
            createdQuery += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }
        sortDirection = (sortDirection == SORT_ASC) ? SORT_DESC : SORT_ASC;
        return createdQuery;
    }
    
}