cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.35.0-beta.1-daily.6869942"

  sha256 arm: "69e6b6ead019c123965e9d220cdce3a79cfbcebe52c5c90c89f191af5f5d0c69",
         intel: "634c60f8f924c385545365a1b52d131dcf883d8e263c578e978461f166bd75ff",
         arm64_linux: "69876cf938b48a8ad025f384462e00d1c62f37e14fb4a372232ae0a9c24b47d5",
         x86_64_linux: "d365a207bf559c1e974e119f86ccc591bfbf511e7aa668435f4f908c22d9a8bf"

  # File extension differs between mac (.zip) and linux (.tar.gz)
  on_macos do
    # Daily releases are staged in a different storage location to keep the repo
    # releases focused on supported releases.
    url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/#{version}/azd-darwin-#{arch}.zip"
    binary "azd-darwin-#{arch}", target: "azd"
  end

  # File extension differs between mac (.zip) and linux (.tar.gz)
  on_linux do
    # Daily releases are staged in a different storage location to keep the repo
    # releases focused on supported releases.
    url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/#{version}/azd-linux-#{arch}.tar.gz"
    binary "azd-linux-#{arch}", target: "azd"
  end

  name "Azure Developer CLI (Daily)"
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"

  conflicts_with cask: "azd"

  postflight_steps do
    # Set .installed-by.txt to "brew" to configure azd behavior for homebrew-managed installs
    write_file ".installed-by.txt", "brew"
  end

  caveats <<~EOS
    The Azure Developer CLI collects usage data and sends that usage data to Microsoft in order to help us improve your experience.
    You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use.

    Read more about Azure Developer CLI telemetry: https://github.com/Azure/azure-dev#data-collection

    azd may download binaries to ~/.azd/bin and, depending on how azd was used on this machine,
    may download binaries to other users' home directories in their .azd/bin directory.
    These binaries will need to be removed manually upon uninstall.
    To remove such binaries from your home directory, run 'rm -rf ~/.azd/bin'.
  EOS
end

