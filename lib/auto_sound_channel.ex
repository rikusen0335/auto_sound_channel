defmodule AutoSoundChannel do

  use Nostrum.Consumer

  alias Nostrum.Api
  alias AutoSoundChannel.{Command, Utils, ErrorHandler}
  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, message, _ws_state}) do
    Command.handle(message)
  end

  def handle_event({:VOICE_STATE_UPDATE, data, _ws_state}) do

    IO.inspect(data)

    if data.channel_id != nil do
      if Utils.is_specific_channel(data.channel_id) do

        user = data.member.user

        with {:ok, origin_channel} <- Api.get_channel(data.channel_id),
             {:ok, new_channel} <- Api.create_guild_channel(data.guild_id, name: user.username, parent_id: 535378822607142914, type: 2)
        do
          # チャンネルを、作成チャンネルの下に移動
          Api.modify_guild_channel_positions(origin_channel.guild_id, [%{id: new_channel.id, position: origin_channel.position}])
          # ユーザーを新チャンネルに移動
          Api.modify_guild_member(origin_channel.guild_id, user.id, channel_id: new_channel.id)
        end
      end
    else if data.channel_id == nil do
      # TODO データに含まれるギルドIDの登録チャンネルを精査して、人がいないチャンネルを削除する
    end
    end
  end

  def handle_event(_event) do
    :noop
  end
end
