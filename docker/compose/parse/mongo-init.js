db.auth('root', '<MONGO_ROOT_PASSWORD>');

db = db.getSiblingDB('<MONGO_DATABASE>');

db.createUser({
  user: '<MONGODB_USER>',
  pwd: '<MONGODB_PWD>',
  roles: [{ role: 'readWrite', db: '<MONGO_DATABASE>' }],
});
