-- Categories: top-level groups like "Work" or "Personal"
create table categories (
    id bigint generated always as identity primary key,
    name text not null unique,
    created_at timestamptz not null default now()
);

--Folders: each folder belongs to one category
create table folders (
    id bigint generated always as identity primary key,
    category_id bigint not null references categories (id) on delete restrict,
    name text not null,
    description text,
    created_at timestamptz not null default now(),
    unique (category_id, name)
);

-- Items: notes or uploaded files inside a folder
create table items (
    id bigint generated always as identity primary key,
    folder_id bigint not null references folders (id) on delete cascade,
    type text not null,
    context text,
    file_path text,
    file_name text,
    file_type text, 
    file_size bigint,
    created_at timestamptz not null default now(),
    constraint items_type_matches_fields check (
        (type = 'note' and file_path is null) or
        (type = 'file' and file_path is not null)
    )
);

-- Indexes: make looking up folders by category and items by folder more efficient
create index idx_folders_category_id on folders (category_id);
create index idx_items_folder_id on items (folder_id);

-- Security: block direct public access to these tables.
-- Only your Node.js server (using a secret key) will be able to read and write.
alter table categories enable row level security;
alter table folders enable row level security; 
alter table items enable row level security; 



