global class EmailService implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        try{
            if(email.textAttachments.size() > 0 && email.textAttachments[0].filename.endsWith('.xml'))
            {
                String myPlainText= '';
                myPlainText = email.plainTextBody;
                List<Contact> contactList = new List<Contact>();
                if(email.textAttachments != null)
                {
                    // Save attachments, if any
                    for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                        String xmlString = Blob.valueOf(tAttachment.body).toString();
                        System.debug(xmlString);
                        for(Contact contactRecord : getContactList(xmlString))
                        {
                            contactList.add(contactRecord);
                        }
                    }
                }
                insert ContactList;
                result.success = true;
            }
        }
        catch(Exception e)
        {
            e.getMessage();
        }
        return result;
    }
    public static List<Contact> getContactList(String xmlString)
    {
        List<Contact> newContactList = new List<Contact> ();
        
        Dom.Document docx = new Dom.Document();
        docx.load(xmlString);
        dom.XmlNode xroot = docx.getrootelement() ;
        
        dom.XmlNode [] xmlRootElements = xroot.getchildelements() ; //Get all Record Elements
        
        for(Dom.XMLNode child : xmlRootElements) //Loop Through Records
        {
            Contact contactRecord = new Contact ();
            
            for (dom.XmlNode node : child.getchildren() ) {                
                if (node.getname() == 'fname') {
                    system.debug('fname' + node.gettext());
                    contactRecord.FirstName = node.gettext();
                }
                if (node.getname() == 'lname') {
                    system.debug('lname' + node.gettext());
                    contactRecord.LastName = node.gettext();
                }
                if (node.getname() == 'phone') {
                    system.debug('phone' + node.gettext());
                    contactRecord.Phone = node.gettext();
                }
                if (node.getname() == 'email') {
                    system.debug('email' + node.gettext());
                    contactRecord.Email = node.gettext();
                }
                if (node.getname() == 'birthdDate') {
                    system.debug('birthdDate' + node.gettext());
                    contactRecord.BirthDate = Date.parse(node.gettext());
                }   
            }
            newContactList.add(contactRecord);
        }
        return newContactList;
    }
}