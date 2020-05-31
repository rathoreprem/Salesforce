public class queryController {
    public boolean showQueryOutput {get; set;}
    public String inputQuery {get; set;}
    
    public queryController() {
        showQueryOutput = false;
    }
    public void executeQuery(){
        try {
            if(inputQuery == null || String.isEmpty(inputQuery))
        
                throw new MyException('put some value');
            	showQueryOutput =true;
       
                }
        catch(MyException ex){
			ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
        		ApexPages.addMessage(msg);       
        
            }
    }
    
    public class MyException extends Exception {} 
}