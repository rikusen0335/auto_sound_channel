defmodule AutoSoundChannel.SoundChannel do
  use Ecto.Schema

  schema "sound_channels" do
    field :category_id, :string
    field :channel_id,  :string
  end
end
