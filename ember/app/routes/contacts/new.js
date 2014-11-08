import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.createRecord('contact');
  },

  actions: {
    create: function() {
      this.get('controller').get('model').save();
      this.transitionTo('');
    }
  }
});
