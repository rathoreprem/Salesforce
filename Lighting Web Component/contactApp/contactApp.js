import { LightningElement } from 'lwc';
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class ContactApp extends LightningElement {

   contactParent = CONTACT_OBJECT;

   handelContactCreated( event ){
       let message = event.detail ? event.detail.message : '';
       let variant = event.detail ? event.detail.variant : '';
       const evt = new ShowToastEvent({
         title: "Contact Created Successfully",
         message,
         variant
       });
       this.dispatchEvent(evt);
   }
}