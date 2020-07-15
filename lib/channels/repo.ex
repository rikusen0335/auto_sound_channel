defmodule AutoSoundChannel.Repo do
  use Ecto.Repo,
    otp_app: :auto_sound_channel,
    adapter: Ecto.Adapters.Postgres
end
