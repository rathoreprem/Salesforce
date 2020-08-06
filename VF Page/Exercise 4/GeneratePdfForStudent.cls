public class GeneratePdfForStudent 
{
   private ApexPages.StandardController controller;
   private Student__c studentRecord;
   
   public GeneratePdfForStudent(ApexPages.StandardController controller)
   {
       this.controller = controller;
       this.controller.addFields(new List<String>{'Class__c'});
       this.studentRecord = (Student__c) this.controller.getRecord();
   }
   
   public void saveAttachment()
   {
       PageReference pdfPage = Page.StudentPDF;
       pdfpage.getParameters().put('id', ApexPages.currentPage().getParameters().get('id'));
       Blob pdf = pdfPage.getContentAsPDF();
       List<Attachment> attachmentList = [SELECT Id, parentId, Body FROM Attachment WHERE parentId=:this.studentRecord.Id];
       if(attachmentList.isEmpty())
       {
           attachmentList.add(new Attachment(parentId=this.studentRecord.Id, Body=pdf, Name='details.pdf'));
       }
       else
       {
           attachmentList[0].Body = pdf;
       }
       insert attachmentList;
   }
}