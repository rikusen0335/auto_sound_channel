import Mix.Config

config :auto_sound_channel,
  ecto_repos: [AutoSoundChannel.Repo]

import_config "#{Mix.env()}.exs"
