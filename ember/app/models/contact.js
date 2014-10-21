import DS from 'ember-data';

export default DS.Model.extend({
  frequency: DS.attr('number'),
  name: DS.attr('string'),
  conversations: DS.hasMany('conversation')
});
