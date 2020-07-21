defmodule AutoSoundChannel.TempChannel do
  use Ecto.Schema

  schema "temp_channels" do
    field :guild_id,   :string
    field :channel_id, :string
  end
end
