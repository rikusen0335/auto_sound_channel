defmodule AutoSoundChannel.ErrorHandler do
  alias Nostrum.Api

  # TODO create template generator
  def send_error(message, error_message) do
    with {:ok, private} = Api.create_dm(message.author.id),
         {:ok, created_msg} = Api.create_message(private.id, error_message <> "\n削除されたメッセージ: \n" <> "```" <> message.content <> "```") do
      Api.delete_message(message)
    end
  end
end
