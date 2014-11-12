import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
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
