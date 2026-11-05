cask "azd" do
  arch arm: "arm64", intel: "amd64"

  version "1.37.3"

  sha256 arm: "2ac43e590f6238cd80cc1215a55567a8b51de921f9d17806ca3ae7ce07e26cee",
         intel: "3b8f5db4a0b4bfc92faa3e0041da77a4ee7da1fcc9183b187b65945b5cfb05c9",
         arm64_linux: "a9f96fd5f9779238ed1675cdbcf8e2d8686b4031a5673ff4958c1e4de6e728e5",
         x86_64_linux: "8bf3e7e86f1d5a9bc1ae6f014c792697660cce04f6333a8091c6e08b7f8c7786"

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

