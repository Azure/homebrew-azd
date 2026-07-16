cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.29.0-beta.1-daily.6575048"

  sha256 arm: "244a1a320165d00de7fd8d620e3a6b2a1ead76f8db55b072482fadd8cf8715c9",
         intel: "06b76e523c2eb2a4740479fa6b49aeac020ff9c4e5eac5d4465c0324351fcdd8",
         arm64_linux: "16210d1f7acdcde9d171a1b58faf651d07e4db4aa5a28767fba589462e4fa94b",
         x86_64_linux: "813a2cc3e66d7d49ebf3a8a971825d4285869f40653bd3eed869cae54c5bac17"

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

  postflight do
    # Set .installed-by.txt to "brew" to configure azd behavior for homebrew-managed installs
    File.write("#{staged_path}/.installed-by.txt", "brew")
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

