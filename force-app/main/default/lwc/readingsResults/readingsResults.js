import { LightningElement, wire } from 'lwc';
import { MessageContext, subscribe, APPLICATION_SCOPE} from 'lightning/messageService';
import SEARCHCRITERIAMC from '@salesforce/messageChannel/SearchCriteriaMessageChannel__c';
import searchReadings from '@salesforce/apex/ReadingSController.searchReadings';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { reduceErrors } from 'c/ldsUtils';

export default class ReadingsResults extends LightningElement {
    readings=[];
    noMatches=false;

    // Initialize messageContext for Message Service
    @wire(MessageContext)
    messageContext;

    // Runs when component is connected, subscribes to BoatMC
    connectedCallback() {
        // recordId is populated on Record Pages, and this component
        // should not update when this component is on a record page.
        if (this.subscription) {
            return;
        }

        // Subscribe to the message channel to retrieve the recordID and assign it to boatId.
        this.subscription = subscribe(this.messageContext, SEARCHCRITERIAMC, (message) => {
            this.executeSearch(message.author, message.genre);

        }, { scope: APPLICATION_SCOPE });  
    }

    executeSearch(author, genre) {
        this.noMatches=false;
        this.readings=[];
        searchReadings({author : author, genre: genre})
        .then(result => {
                if (result){
                    this.readings=result;
                }
                if (0==this.readings.length) {
                    this.noMatches=true;
                }
            })
        .catch(err => {
            let errors=reduceErrors(err).reduce((accumulator, currentValue) => accumulator.concat(', ', currentValue), '');
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error getting results',
                    message: errors.substring(2),
                    variant: 'error'
                })
            );
        })
    }
}