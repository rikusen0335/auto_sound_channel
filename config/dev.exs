import Mix.Config

config :auto_sound_channel, AutoSoundChannel.Repo,
  database: "auto_sound_channel_repo",
  username: "root",
  password: "root",
  hostname: "localhost"

import_config "dev.secret.exs"
