import Ember from 'ember';

export default Ember.ObjectController.extend({
  actions: {
     recordConversation: function() {
       var contact = this.get('model');
       this.store.createRecord('conversation', {
         contact: contact
       }).save();
       this.transitionToRoute('contacts.show');
     }
   }
});
