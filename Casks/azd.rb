cask "azd" do
  arch arm: "arm64", intel: "amd64"

  version "1.23.9"

  sha256 arm: "4f68c0b6110141256efd579fd73193d432ce489ae6d193210fdefbb15e1ff983",
         intel: "19a09c591510f793f2edc64bf259da8f9499357325816b6805446a222a0bc1ac",
         arm64_linux: "c32d489ac550fdfa7c7f94c1296ff5a8f94e2981f8e6af31e7061846acc0bfb6",
         x86_64_linux: "f3776d0510e0d1319cf8ab0dba1762873987639eee1b9834dae189f5208fa752"

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
