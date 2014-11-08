import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    this.store.find('contact');
    return this.store.filter('contact', function(contact) {
      return !contact.get('isNew');
    });
  }
});
