defmodule NervesSystemSuperbird.MixProject do
  use Mix.Project

  @github_organization "ericr3r"
  @app :nerves_system_superbird
  @source_url "https://github.com/#{@github_organization}/#{@app}"
  @version Path.join(__DIR__, "VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: @app,
      version: @version,
      # Because we're using OTP 28, we need to enforce Elixir 1.17 or later.
      elixir: "~> 1.17",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def cli do
    [
      preferred_envs: %{docs: :docs, "hex.build": :docs, "hex.publish": :docs},
      default_target: :target
    ]
  end

  def application do
    []
  end

  defp nerves_package do
    [
      type: :system,
      artifact_sites: [
        {:github_releases, "#{@github_organization}/#{@app}"}
      ],
      artifact_checksum: true,
      build_runner_opts: build_runner_opts(),
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      # The :env key is an optional experimental feature for adding environment
      # variables to the crosscompile environment. These are intended for
      # llvm-based tooling that may need more precise processor information.
      env: [
        {"TARGET_ARCH", "aarch64"},
        {"TARGET_CPU", "cortex_a53"},
        {"TARGET_OS", "linux"},
        {"TARGET_ABI", "gnu"},
        {"TARGET_GCC_FLAGS",
         "-mabi=lp64 -fstack-protector-strong -mcpu=cortex-a53 -fPIE -pie -Wl,-z,now -Wl,-z,relro"}
      ],
      checksum: source_finger_print_files()
    ]
  end

  defp deps do
    [
      {:nerves, "~> 1.11 or ~> 2.0 or ~> 2.0.0-dev", runtime: false},
      {:nerves_system_br, "1.35.3", runtime: false},
      {:nerves_toolchain_aarch64_nerves_linux_gnu, "~> 15.3.0", runtime: false},
      {:nerves_system_linter, "~> 0.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.22", only: :docs, runtime: false}
    ]
  end

  defp description do
    """
    Nerves System - Raspberry Pi Zero and Zero W
    """
  end

  defp docs do
    [
      extras: ["README.md", "CHANGELOG.md"],
      main: "readme",
      assets: %{"assets" => "./assets"},
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end

  defp package do
    [
      files: package_files(),
      licenses: ["GPL-2.0-only", "GPL-2.0-or-later"],
      links: %{
        "GitHub" => @source_url,
        "REUSE Compliance" =>
          "https://api.reuse.software/info/github.com/ericr3r/nerves_system_superbird"
      }
    ]
  end

  defp source_finger_print_files do
    [
      "config/config.exs",
      "fwup_include",
      "rootfs_overlay",
      "bootargs.txt",
      "fwup.conf",
      "linux-6.6.defconfig",
      "mix.exs",
      "nerves_defconfig",
      "post-build.sh",
      "post-createfs.sh"
    ]
  end

  defp package_files do
    [
      "CHANGELOG.md",
      "LICENSES/*",
      "checksum.exs",
      "README.md",
      "REUSE.toml",
      "VERSION"
    ] ++ source_finger_print_files()
  end

  defp build_runner_opts() do
    # Download source files first to get download errors right away.
    [make_args: primary_site() ++ ["source", "all", "legal-info"]]
  end

  defp primary_site() do
    case System.get_env("BR2_PRIMARY_SITE") do
      nil -> []
      primary_site -> ["BR2_PRIMARY_SITE=#{primary_site}"]
    end
  end

end
