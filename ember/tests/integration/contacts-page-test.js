import Ember from 'ember';
import startApp from '../helpers/start-app';

var App, server;

module('Integration - Contacts Page', {
  setup: function() {
    App = startApp();
    var contacts = [
      { id: 1, name: 'Bugs Bunny', conversation_ids: [1,2], frequency: 7 },
      { id: 2, name: 'Wile E. Coyote', conversation_ids: [3], frequest: 7 },
      { id: 3, name: 'Yosemite Sam', conversation_ids: [4,5,6], frequency: 14}
    ];

    var conversations = [
      { id: 1, created_at: "2014-09-28 22:57:42", contact_id: 1 },
      { id: 2, created_at: "2014-09-28 22:57:42", contact_id: 1 },
      { id: 3, created_at: "2014-09-28 22:57:42", contact_id: 2 },
      { id: 4, created_at: "2014-09-28 22:57:42", contact_id: 3 },
      { id: 5, created_at: "2014-09-28 22:57:42", contact_id: 3 },
      { id: 6, created_at: "2014-09-28 22:57:42", contact_id: 3 }
    ];

    server = new Pretender(function() {
      this.get('/api/contacts', function(request) {
        return [
          200,
          {"Content-Type": "application/json"}, JSON.stringify({
            contacts: contacts,
            conversations: conversations
          })
        ];
      });

      this.get('/api/contacts/:id', function(request) {
        var contact = contacts.find(function(contact) {
          if (contact.id === parseInt(request.params.id, 10)) {
            return contact;
          }
        });

        var contactConversations = conversations.filter(function(conversation) {
          if (conversation.contact_id === contact.id) {
            return true;
          }
        });

        return [
          200,
          {"Content-Type": "application/json"}, JSON.stringify({
            contact: contact,
            conversations: contactConversations
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

test('Should allow navigation to the contacts page from the landing page', function() {
  visit('/').then(function() {
    click('a:contains("Contacts")').then(function() {
      equal(find('h3').text(), 'Contacts');
    });
  });
});

test('Should list all contacts and number of presentations', function() {
  visit('/contacts').then(function() {
    equal(find('a:contains("Bugs Bunny (2)")').length, 1);
    equal(find('a:contains("Wile E. Coyote (1)")').length, 1);
    equal(find('a:contains("Yosemite Sam (3)")').length, 1);
  });
});

test('Should be able to navigate to a contact page', function() {
  visit('/contacts').then(function() {
    click('a:contains("Bugs Bunny")').then(function() {
      equal(find('h4').text(), 'Bugs Bunny');
    });
  });
});

test('Should be able visit a contact page', function() {
  visit('/contacts/1').then(function() {
    equal(find('h4').text(), 'Bugs Bunny');
  });
});

test('Should list all conversations for a contact', function() {
  visit('/contacts/1').then(function() {
    equal(find('li:contains("2014-09-28 22:57:42")').length, 2);
  });
});
