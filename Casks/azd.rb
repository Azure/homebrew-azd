cask "azd" do
  arch arm: "arm64", intel: "amd64"

  version "1.24.1"

  sha256 arm: "04874582c3e75e392d0a889d97425ed71327e9108bac3b9e2d41ddea1a493b9a",
         intel: "904caee1cf19498d73ab7f97962fd7495d8f1e92ebc54f49e2628dfaceb4915c",
         arm64_linux: "8ece20a6e12f582092ea1114cc683f9829e74a0da392bd33596ef262ae2f8974",
         x86_64_linux: "363cdb926858d8132d8668b61c6e8948c529e081d56254ed8ea02e3e3a341a3e"

  # File extension differs between mac (.zip) and linux (.tar.gz)
  on_macos do
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_#{version}/azd-darwin-#{arch}.zip"
    binary "azd-darwin-#{arch}", target: "azd"
  end

  # File extension differs between mac (.zip) and linux (.tar.gz)
  on_linux do
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_#{version}/azd-linux-#{arch}.tar.gz"
    binary "azd-linux-#{arch}", target: "azd"
  end

  name "Azure Developer CLI"
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"

  conflicts_with cask: "azd@daily"

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

