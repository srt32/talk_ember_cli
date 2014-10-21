import Ember from 'ember';
import startApp from '../helpers/start-app';

var App, server;

var lastConversationAt = "2014-09-28 22:57:42";

module('Integration - Contact Page', {
  setup: function() {
    App = startApp();
    var contact = [
      { id: 1, name: 'Bugs Bunny', conversation_ids: [1,2], frequency: 7 },
    ];

    var conversations = [
      { id: 1, created_at: "2014-09-01 22:57:42", contact_id: 1 },
      { id: 2, created_at: lastConversationAt, contact_id: 1 },
    ];

    server = new Pretender(function() {
      this.get('/api/contacts/:id', function(request) {
        return [
          200,
          {"Content-Type": "application/json"}, JSON.stringify({
            contact: contact,
            conversations: conversations,
          })
        ];
      });
    });
  },

  teardown: function() {
    Ember.run(App, 'destroy');
    server.shutdown();
  }
});

test("Should show contact's frequency", function() {
  visit('/contacts/1').then(function() {
    equal(find('.frequency').text(), 7);
  });
});

test("Should show contact's most recent conversation date", function() {
  var daysAgo = new Date(Date.now() - Date.parse(lastConversationAt)).getDate();

  visit('/contacts/1').then(function() {
    equal(find('.last-conversation-days-ago').text(), "It's been " + daysAgo + " days");
  });
});
