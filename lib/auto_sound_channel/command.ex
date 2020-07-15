defmodule AutoSoundChannel.Command do
  alias Nostrum.Api
  alias AutoSoundChannel.ErrorHandler
  alias AutoSoundChannel.Help
  alias AutoSoundChannel.Repo

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

  def execute([@command_prefix, "get"], message) do
    IO.inspect AutoSoundChannel.SoundChannel |> AutoSoundChannel.Repo.all
  end

  def execute([@command_prefix, "set", category_id, channel_id], message) do
    channel = %AutoSoundChannel.SoundChannel{category_id: category_id, channel_id: channel_id}
    Repo.insert!(channel)
  end

  def execute([@command_prefix, "ping"], message) do
    Api.create_message(message, "pong!")
  end

  def execute([@command_prefix, "add", _guild_id, _channel_id], message) do
    ErrorHandler.send_error(message, "引数が足りません！カテゴリIDかチャンネルIDを正しく指定してください。")
  end

  def execute([@command_prefix, "add", guild_id, channel_id], message) do
    # TODO 作成用のチャンネルを追加する
  end

  def execute([@command_prefix, "remove", _guild_id, _channel_id], message) do
    ErrorHandler.send_error(message, "引数が足りません！カテゴリIDかチャンネルIDを正しく指定してください。")
  end

  def execute([@command_prefix, "remove", guild_id, channel_id], message) do
    # TODO 作成用のチャンネルを削除する
  end

  def execute([@command_prefix, "name", name], message) do
    # TODO 名前を変えるやつ
  end


  # If play wrong command
  def execute([@command_prefix], message), do: Help.help(message.channel_id)
  def execute([@command_prefix, _], message), do: Help.help(message.channel_id)
  def execute(_, message), do: :ignore

end
