import Ember from 'ember';
import startApp from '../helpers/start-app';

var App, server;

module('Integration - Contacts Page', {
  setup: function() {
    App = startApp();
    var contacts = [
      {
        id: 1,
        name: 'Bugs Bunny'
      },
      {
        id: 2,
        name: 'Wile E. Coyote'
      },
      {
        id: 3,
        name: 'Yosemite Sam'
      }
    ];

    server = new Pretender(function() {
      this.get('/api/contacts', function(request) {
        return [
          200,
          {"Content-Type": "application/json"}, JSON.stringify({contacts: contacts})
        ];
      });

      this.get('/api/contacts/:id', function(request) {
        var contact = contacts.find(function(contact) {
          if (contact.id === parseInt(request.params.id, 10)) {
            return contact;
          }
        });

        return [
          200,
          {"Content-Type": "application/json"}, JSON.stringify({contact: contact})
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

test('Should list all contacts', function() {
  visit('/contacts').then(function() {
    equal(find('a:contains("Bugs Bunny")').length, 1);
    equal(find('a:contains("Wile E. Coyote")').length, 1);
    equal(find('a:contains("Yosemite Sam")').length, 1);
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
