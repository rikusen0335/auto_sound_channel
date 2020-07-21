defmodule AutoSoundChannel.Utils do
  alias AutoSoundChannel.{Repo, SoundChannel, TempChannel}
  alias Nostrum.Api

  # Sound Channels
  def add_channel(category_id, channel_id) do
    IO.puts("Adding channel")
    channel = %SoundChannel{category_id: category_id, channel_id: channel_id}
    case Repo.insert(channel) do
      {:ok, channel} -> {:ok, channel}
      {:error, _changeset} -> :error
    end
  end

  def get_all_channels() do
    SoundChannel
      |> Repo.all()
  end

  #@spec is_specific_channel(Integer) :: Boolean
  def is_specific_channel(channel_id) do
    get_all_channels()
      |> Enum.find_value(fn x -> x.channel_id == Integer.to_string(channel_id) end)
  end

  # Sound Channels End


  # Temp Channels

  def add_temp_channel(guild_id, channel_id) do
    IO.puts("Adding TEMP channel")
    channel = %TempChannel{guild_id: Integer.to_string(guild_id), channel_id: Integer.to_string(channel_id)}
    case Repo.insert(channel) do
      {:ok, channel} -> {:ok, channel}
      {:error, _changeset} -> :error
    end
  end

  def get_all_temp_channels() do
    TempChannel
      |> Repo.all()
  end

  _ = """
  def get_specific_temp_channels(guild_id) do
    get_all_temp_channels()
      |> Enum.filter(fn x -> x.guild_id == Integer.to_string(guild_id) end) # [{guild_id, "1234", guild_id, "2345", ...}]
      |> IO.inspect()
  end
  """

  @spec is_specific_temp_channel(any, any) :: Boolean
  def is_specific_temp_channel(guild_id, channel_id) do
    get_all_temp_channels()
      |> Enum.filter(fn x -> x.guild_id == Integer.to_string(guild_id) end) # [{guild_id, "1234", guild_id, "2345", ...}]
      |> Enum.find_value(fn x -> x.channel_id == Integer.to_string(channel_id) end)
  end

  def is_deletable_channel(channel_id) do
      Api.get_channel(channel_id)
  end

  # Temp Channels End
end
