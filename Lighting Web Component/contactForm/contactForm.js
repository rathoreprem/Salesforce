import { LightningElement, api } from 'lwc';

import ACCOUNT_FIELD from "@salesforce/schema/Contact.AccountId";
import FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import  EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import  PHONE_FIELD from "@salesforce/schema/Contact.Phone";

export default class ContactForm extends LightningElement {

    @api contactObject;
    myFields = [ACCOUNT_FIELD, FIRSTNAME_FIELD, LASTNAME_FIELD,EMAIL_FIELD,PHONE_FIELD];
    contactId = null;
    contactView = false;

    handelContactCreated(event) {
        this.contactView = true;
        this.contactId = event.detail.id;
        this.createAndDispatchToast("contact ID: " + this.contactId, "success");
    }

    handelError(event) {
        createAndDispatchToast("error message : " + event.detail.error.Messages, "error");
    }

    createAndDispatchToast(message, variant) {
        const evt = new CustomEvent("contactcreated", { detail : { message, variant }});
        this.dispatchEvent(evt);
    }
}