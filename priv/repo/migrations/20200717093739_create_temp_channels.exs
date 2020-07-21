defmodule AutoSoundChannel.Repo.Migrations.CreateTempChannels do
  use Ecto.Migration

  def change do
    create table(:temp_channels) do
      add :guild_id,   :string
      add :channel_id, :string
    end
  end
end
