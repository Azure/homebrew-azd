cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.38.0-beta.1-daily.7028353"

  sha256 arm: "be1825c170fea1846ac632d96fe2621e13afa4f5a31283c80483c8f6f892c842",
         intel: "9c432e984d12c7c4ce4d6437fc6c4fcee39b73795bac492b68a494f9ab084548",
         arm64_linux: "d93a048822c4f00db5fdabe2560f4adf91731206b32940d1e2209826d47e24a5",
         x86_64_linux: "d5815d1e467a7e182e8dca29da915edda3743ac36580db42f2f8575d3eb002f4"

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

