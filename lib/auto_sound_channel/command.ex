defmodule AutoSoundChannel.Command do
  alias Nostrum.Api
  alias AutoSoundChannel.{ErrorHandler, Help, Utils, Repo}

  @command_prefix ".asc"

  defp actionable_command?(message) do
    if message.author.bot == nil do
      true
    end
  end

  def handle(message) do
    if actionable_command?(message) do
      message.content
      |> String.trim
      |> String.split
      |> execute(message)
    end
  end

  def execute([@command_prefix, "ping"], message) do
    Api.create_message(message, "pong!")
  end

  def execute([@command_prefix, "get", channel_id], message) do
    elem(Integer.parse(channel_id), 0)
      |> Api.get_channel()
      |> IO.inspect()
  end

  def execute([@command_prefix, "add", category_id, channel_id], message)
    when is_nil(category_id)
    when is_nil(channel_id) do
    ErrorHandler.send_error(message, "引数が足りません！カテゴリIDかチャンネルIDを正しく指定してください。")
  end

  def execute([@command_prefix, "add", category_id, channel_id], message) do
    case Utils.add_channel(category_id, channel_id) do
      {:ok, channel} -> Api.create_message!(message, channel.channel_id <> "が登録されました。")
    end
  end

  def execute([@command_prefix, "remove", category_id, channel_id], message)
    when is_nil(category_id)
    when is_nil(channel_id) do
    ErrorHandler.send_error(message, "引数が足りません！カテゴリIDかチャンネルIDを正しく指定してください。")
  end

  def execute([@command_prefix, "remove", guild_id, channel_id], message) do
    # TODO 作成用のチャンネルを削除する
  end

  def execute([@command_prefix, "name", name], message) do
    # TODO 名前を変えるやつ
  end


  # If play wrong command
  def execute([@command_prefix], message), do: Help.help(message)
  def execute([@command_prefix, _], message), do: Help.help(message)
  def execute(_, _message), do: :ignore

end
