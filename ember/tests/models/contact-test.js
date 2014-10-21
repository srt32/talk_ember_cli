//import Ember from 'ember';
import { test, moduleForModel } from 'ember-qunit';

moduleForModel('contact', 'Contact Model');
moduleForModel('conversation', 'Conversation Model');

test('score', function() {
  var contact = this.subject({ frequency: 10, conversations: [] });

  equal(contact.get('score'), 50);
});
