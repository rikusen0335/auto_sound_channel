defmodule MainConsumer do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias AutoSoundChannel.RedisFunc

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:VOICE_STATE_UPDATE, data, _ws_state}) do

    # guild_idも取らないといけないかも？
    case data.channel_id do
      # TODO 指定チャンネルを可変に
      560328532316913664 ->

        user = data.member.user
        # 元のチャンネルの情報をとってくる
        origin_channel = elem(Api.get_channel(data.channel_id), 1)
        # 新しく作ったVCチャンネルの情報を格納する
        # TODO カテゴリを可変に
        new_channel = elem(Api.create_guild_channel(data.guild_id, name: user.username, parent_id: 535378822607142914, type: 2), 1)

        # チャンネルを、作成チャンネルの下に移動
        Api.modify_guild_channel_positions(origin_channel.guild_id, [%{id: new_channel.id, position: origin_channel.position}])
        # ユーザーを新チャンネルに移動
        Api.modify_guild_member(origin_channel.guild_id, user.id, channel_id: new_channel.id)


        #IO.inspect(new_channel)
        IO.inspect(origin_channel)

      nil ->
        # TODO 削除しないといけない
        :ignore
      _ ->
        :ignore
    end
  end

  def handle_event({:MESSAGE_CREATE, message, _ws_state}) do
    cmd_list = String.split(message.content, " ")

    # cmd_listの一番初め
    case hd cmd_list do
      ".asc" ->

        if cmd_list[1] && cmd_list[2] do
          category_id = cmd_list[1]
          channel_id = cmd_list[2]

          RedisFunc.add_primary_channel(channel_id)


        else
          Api.create_message(message.channel_id, content: "引数が足りません！カテゴリIDかチャンネルIDを正しく指定してください。")
        end

      _ ->
        :ignore
    end
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
