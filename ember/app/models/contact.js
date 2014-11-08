import DS from 'ember-data';

export default DS.Model.extend({
  frequency: DS.attr('number'),
  name: DS.attr('string'),
  conversations: DS.hasMany('conversation'),

  score: function() {
    return 0;
  },

  lastConversationDaysAgo: function() {
    var parsedLastAt = Date.parse(this.get('lastConversationAt'));

    if (!parsedLastAt) {
      return 0;
    } else {
      var diff = Date.now() - parsedLastAt;
      return new Date(diff).getDate();
    }
  }.property('lastConversationAt'),

  lastConversationAt: function() {
    var conversationLength = this.get('conversations.length');
    var lastConversation = this.get('conversations').sortBy('createdAt')[conversationLength - 1];
    if (!lastConversation) {
      return null;
    } else {
      return lastConversation.get('created_at');
    }
  }.property('conversations')
});
