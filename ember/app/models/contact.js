import DS from 'ember-data';

export default DS.Model.extend({
  frequency: DS.attr('number'),
  name: DS.attr('string'),
  conversations: DS.hasMany('conversation'),

  lastConversationDaysAgo: function() {
    var diff = Date.now() - Date.parse(this.get('lastConversationAt'));
    return new Date(diff).getDate();
  }.property('lastConversationAt'),

  lastConversationAt: function() {
    var conversationLength = this.get('conversations.length');
    var lastConversation = this.get('conversations').sortBy('createdAt')[conversationLength - 1];
    return lastConversation.get('created_at');
  }.property('conversations')
});
