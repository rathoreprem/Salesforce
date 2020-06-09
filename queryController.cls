public class queryController {
    public boolean showQueryOutput {get; set;}
    public String inputQuery {get; set;}
    
    public queryController() {
        showQueryOutput = false;
    }
    public void executeQuery(){

        if(inputQuery == null || String.isEmpty(inputQuery))
                showQueryOutput =true;
            System.debug('hiiiii');
        
        }
        
    }