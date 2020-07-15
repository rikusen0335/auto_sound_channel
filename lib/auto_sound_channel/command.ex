defmodule AutoSoundChannel.Command do
  alias Nostrum.Api
  alias AutoSoundChannel.ErrorHandler
  alias AutoSoundChannel.Help

  @command_prefix ".asc"

  defp actionable_command?(message) do
    if message.author.bot == nil do
      ErrorHandler.send_error(message, "コマンドを使用するには、こちら[#{API_URL}]でログインしてください。")
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

  end

  def execute([@command_prefix, "set", value], message) do

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
  def execute(_, message), do: ErrorHandler.send_error(message, "コマンドまたは引数を指定してください")


  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
