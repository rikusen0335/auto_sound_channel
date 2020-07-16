defmodule AutoSoundChannel.Repo.Migrations.CreateChannel do
  use Ecto.Migration

  def change do
    create table(:sound_channels) do
      add :category_id, :string
      add :channel_id,  :string
    end
  end
end
