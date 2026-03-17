cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.24.0-beta.1-daily.6022270"

  sha256 arm: "afb8a0347ceea324f6659d418ca79b62dcdb08a9709e213a32e10792f69e7dc9",
         intel: "6da16d67dffaacbf763b7af06337e9e2e87a50c1e04f4a3ec38e9eb58061afc3",
         arm64_linux: "d0c62aee9cdcb61e8f36135bbb22e4bf29df30ba8eac76c36d04b3061464ff88",
         x86_64_linux: "44bd63ef10e8b831b891b925aaca3925784cbf155a5444abf60b0c3e40ed4f71"

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

