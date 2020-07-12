defmodule AutoSoundChannel.RedisFunc do
  @sound_channel_ids "sound_channel_ids"
  @primary_sound_channel_ids "primary_sound_channel_ids"

  def conn() do
    {:ok, conn} = Redix.start_link(host: "localhost", port: 6380)
    conn
  end

  def add_channel(channel_id) do
    conn = conn()
    Redix.command(conn, ["rpush", @sound_channel_ids, channel_id])
  end

  def remove_channel(channel_id) do
    conn = conn()
    Redix.command(conn, ["lrem", @sound_channel_ids, 0, channel_id])
  end

  def get_all_channels() do
    conn = conn()
    Redix.command(conn, ["lrange", @sound_channel_ids, 0, -1])
  end

  def add_primary_channel(channel_id) do
    conn = conn()
    Redix.command(conn, ["rpush", @primary_sound_channel_ids, channel_id])
  end

  def remove_primary_channel(channel_id) do
    conn = conn()
    Redix.command(conn, ["lrem", @primary_sound_channel_ids, 0, channel_id])
  end

  def get_all_primary_channel() do
    conn = conn()
    Redix.command(conn, ["lrange", @primary_sound_channel_ids, 0, -1])
  end
end
