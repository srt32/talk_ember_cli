import Ember from 'ember';
import startApp from '../helpers/start-app';
import Ember from 'ember';

var App;

module('Integration - Landing Page', {
  setup: function() {
    App = startApp();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test('Should welcome me to the app', function() {
  visit('/').then(function() {
    equal(find('h2#title').text(), 'Welcome to Talk');
  });
});
