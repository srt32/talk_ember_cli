import Ember from 'ember';

export default Ember.ObjectController.extend({
  actions: {
    create: function() {
      this.get('model').save();
      this.transitionToRoute('contacts');
    }
  }
});
