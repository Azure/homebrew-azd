cask "azd@daily" do
  arch arm: "arm64", intel: "amd64"

  version "1.24.2-daily.6240568"

  sha256 arm: "e1b807e90dfc1c1256f0168776948c1ecf71ae09e849471bd37e90f4c738c293",
         intel: "60cf950f550145c56baab16b2ccf467c3ee3f7364d9a8f1050f1cb8caad24ac8",
         arm64_linux: "5dfa6d96383dcdb86a80207005bcda28c4aa3aa48d752f7fa51de5ff14314a9d",
         x86_64_linux: "c53b0e3acb5e25ab4f5e34d9bd59db8fa6aba2b0c16fea05771ae78d39a96b2b"

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

