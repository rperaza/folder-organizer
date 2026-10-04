-- =========================================
-- Sample data for development
-- =========================================

insert into categories (name)
values ('Work'), ('Personal');

insert into folders (category_id, name, description)
values
  ((select id from categories where name = 'Work'), 'Client Projects', 'Notes and documents for client work'),
  ((select id from categories where name = 'Work'), 'Meeting Notes', 'Notes from team meetings'),
  ((select id from categories where name = 'Personal'), 'Recipes', 'Favorite recipes to try');

insert into items (folder_id, type, title, content)
values
  ((select id from folders where name = 'Client Projects'), 'note', 'Kickoff checklist', 'Confirm scope, timeline, and budget.'),
  ((select id from folders where name = 'Meeting Notes'), 'note', 'Monday standup', 'Review last week and set priorities.'),
  ((select id from folders where name = 'Recipes'), 'note', 'Pancakes', '2 cups flour, 2 eggs, 1.5 cups milk.');