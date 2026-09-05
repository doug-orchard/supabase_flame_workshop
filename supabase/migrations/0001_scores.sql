create table public.scores (
  id uuid primary key references auth.users (id) on delete cascade,
  name text not null,
  wins integer not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.scores enable row level security;

create policy "Scores are readable by everyone"
  on public.scores for select
  using (true);

create policy "Players can insert their own score"
  on public.scores for insert
  with check (auth.uid() = id);

create policy "Players can update their own score"
  on public.scores for update
  using (auth.uid() = id)
  with check (auth.uid() = id);
  
