defmodule AutoSoundChannel.Help do

  alias Nostrum.Api

  import Nostrum.Struct.Embed

  @command_prefix ".asc"

  def help(message) do
    {:ok, private} = Api.create_dm(message.author.id)
    embed =
      %Nostrum.Struct.Embed{}
      |> put_title("コマンドリスト")
      |> put_field(@command_prefix <> " name <名前>", "チャンネルの名前を変更します")
      |> put_field(@command_prefix <> " help", "このヘルプリストを送ります")

    Api.create_message!(private.id, embed: embed)
  end
end
