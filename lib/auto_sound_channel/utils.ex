defmodule AutoSoundChannel.Utils do
  alias AutoSoundChannel.{Repo, SoundChannel}

  @spec is_specific_channel(Integer) :: Boolean
  def is_specific_channel(channel_id) do
    SoundChannel
      |> Repo.all()
      |> Enum.find_value(fn x -> x.channel_id == Integer.to_string(channel_id) end)
      |> IO.inspect()
  end

  def get_all_channels() do
    SoundChannel
      |> Repo.all()
      |> IO.inspect()
  end
end
