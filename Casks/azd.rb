cask "azd" do
  arch arm: "arm64", intel: "amd64"

  version "1.31.1"

  sha256 arm: "f0cabf95fa389386914faa8c14f2c5e49b9520eee27c3d56db7fc20ecd80ed24",
         intel: "f98d220ba83dfc4da4b85bfd1936545da05dfc616e446f43462e8990dd38b324",
         arm64_linux: "0e1079915d50fa1cc48f4cdceac9309791f23ba5538e4862b01ed4b087273cdb",
         x86_64_linux: "1a9350ec48a0b353f14dbed0b80c49bd55fe6be957dd0dbe5c79ac07bb098493"

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

