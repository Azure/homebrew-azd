cask "azd" do
  arch arm: "arm64", intel: "amd64"

  version "1.36.0"

  sha256 arm: "750d6b70067dc7d5d31f17a41d676f5eb096acdcbb01349413339bbdad5bda38",
         intel: "6ad3fffbcf40d51a46be2eb7b2c84188344920f6d99cd3a5d493c2455a4b198a",
         arm64_linux: "853d3c5bf1072255619890de117e578f5345fe350b698a85cffed5bc94f729ac",
         x86_64_linux: "db787bd1a0e12584d3be1e3c73e439f53ec8b850b9c714defb0ae9f0e698e650"

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

