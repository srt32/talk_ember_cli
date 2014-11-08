import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model: function() {
    this.store.find('contact');
    return this.store.filter('contact', function(contact) {
      return !contact.get('isNew');
    });
  }
});
