cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.35.0-beta.1-daily.6868735"

  sha256 arm: "c826ad582af2b2bfd8d17692dca5fc2e2c4e3e4d6dd0dfc1cfd6823e9b52c154",
         intel: "ad95fe02114c35a95445ee16102c0bd247f4a2fffbeffabfd519228dcf01e959",
         arm64_linux: "9e276465b42466de30cda287451ad5698215c20b630e0d6eca458998cce07a86",
         x86_64_linux: "e8735b3eecc7ea806ced996e31b4ee41c43928f2bc0a068b9ade9e09af1bbb38"

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

