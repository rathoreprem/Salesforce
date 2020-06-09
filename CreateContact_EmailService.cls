global class CreateContact_EmailService implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,  Messaging.Inboundenvelope envelope)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Messaging.InboundEmail.TextAttachment[] attachments = email.textAttachments;
        
        if(attachments != null)
        {
            //parsing each attachment
            for(Messaging.InboundEmail.TextAttachment xmlAttachment : attachments)
            {
                List<Contact> contacts = new List<Contact>();
                String fileContent = xmlAttachment.body;
                DOM.Document doc = new DOM.Document();
                doc.load(fileContent);
                
                //Getting root element from xml attachment
                Dom.XMLNode root = doc.getRootElement();  
                
                //Iterating on child(contact) of root element
                
                for(Dom.XmlNode contactRecord : root.getChildElements()){
                    String firstName = contactRecord.getChildElement('fname',null).getText(); // text inside <fname> field
                    String lastName = contactRecord.getChildElement('lname',null).getText();
                    String mailingCity = contactRecord.getChildElement('mailingCity',null).getText();
                    String mailingState = contactRecord.getChildElement('mailingState',null).getText();
                    String mailingCountry = contactRecord.getChildElement('mailingCountry',null).getText();
                    System.debug('fname : ' + firstName + '  lname : '+ lastName);
                    Contact con = new Contact( FirstName = firstName, LastName = lastName , MailingCity = mailingCity , MailingState = mailingState , MailingCountry = mailingCountry);
                    contacts.add(con);
                }
                
                insert contacts;
            }
        }
        return result;
    }
}