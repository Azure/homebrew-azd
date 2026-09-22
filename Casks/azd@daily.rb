cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.35.0-beta.1-daily.6868543"

  sha256 arm: "44fb041b85e7a64da2cb57e7606583f8670d932e355be34e13882f44f54995a5",
         intel: "e4297b20b090c4d86846e02d34a8922d4ac579f4514a83d2c85e15b5dd54ddea",
         arm64_linux: "f5f890ca400c96e1043681f1deb93d79286be22660a635f8cb2e30651b5a03f5",
         x86_64_linux: "0b53aa94b1b9eef7830bf71a4ab2d19d3a5c038737c46cb7efd4ff5cebe85499"

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

